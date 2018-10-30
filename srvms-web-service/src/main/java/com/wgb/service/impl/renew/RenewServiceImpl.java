package com.wgb.service.impl.renew;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.pays.web.ApiPaysOrderService;
import com.wgb.service.dubbo.urms.web.ApitComponentService;
import com.wgb.service.renew.RenewService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.JSONUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.omg.CORBA.OBJ_ADAPTER;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 商户续费
 */
@Service
public class RenewServiceImpl implements RenewService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RenewServiceImpl.class);

    private static final String NAME_SPACE = "shardName.com.wgb.service.impl.renew.RenewServiceImpl.";

    @Autowired
    private CommonDalClient dalClient;

    @Autowired
    private ApiPaysOrderService apiPaysOrderService;

    @Autowired
    private SrvUserService srvUserService;

    @Autowired
    private ApitComponentService apitComponentService;


    public List<Map<String, Object>> queryProductInfoByCondition(Map<String, Object> params) {
        List<Map<String ,Object>> producstInfos = new ArrayList<>();
        ZLRpcResult rpcResult = apitComponentService.queryComponentExceptSMS(new HashMap<String, Object>());
        if (rpcResult.success()){
            producstInfos = ( List<Map<String ,Object>>)rpcResult.getData();
        }
        return producstInfos;
    }

    public Page queryProductInfo(Map<String, Object> params) {
        Page pageInfo = new Page();
        ZLRpcResult rpcResult = apitComponentService.queryComponentUnitPrice(new HashMap<String, Object>());
        if(rpcResult.success()){
            pageInfo = (Page)rpcResult.getData();
        }
        return pageInfo;
    }


    public Page queryOrderInfoByCondition(Map<String, Object> params) {
        Map<String ,Object> updateParams = new HashMap<>();  // 更新失效订单
        updateParams.put("servercode" ,MapUtils.getString(params ,"servercode"));
        updateOrderStatusByServerCode(updateParams);
        return dalClient.getReadOnlyDalClient().queryForListPage(NAME_SPACE + "queryOrderInfoByCondition", params);
    }

    private int  updateOrderStatusByServerCode(Map<String, Object> params){
        return dalClient.getDalClient().execute(NAME_SPACE + "updateOrderStatusByServerCode", params);
    }

    public List<Map<String, Object>> queryMerchantDetail(Map<String, Object> params) {
        return dalClient.getReadOnlyDalClient().queryForList(NAME_SPACE + "queryMerchantDetail", params);
    }

    public Map<String, Object> queryMerchantChainDetail(Map<String, Object> params) {
        return dalClient.getReadOnlyDalClient().queryForMap(NAME_SPACE + "queryMerchantChainDetail", params);
    }

    public String deleteOrderInfo(Map<String, Object> params) {
        String message;
        int count = dalClient.getDalClient().execute(NAME_SPACE + "deleteOrderInfo", params);
        if (count == 1){
            message =  "删除成功!";
        }else{
            message =  "订单不存在!";
        }
        return message;
    }

    public String saveOrderInfoByBillCode(Map<String, Object> params) throws ParseException {
        return saveOrderInfoByMerchant(params);
    }

    public void updateRenewPayInfo(Map<String, Object> params) {
        dalClient.getDalClient().execute(NAME_SPACE + "updateRenewPayInfo" ,params);
        // 修改营销助手码
        batchUpdateSaleAssistantCodes(params);
    }

    private void batchUpdateSaleAssistantCodes (Map<String ,Object> params){
        Map<String ,Object> saleassistantcodes = (Map<String ,Object>)MapUtils.getMap(params, "saleassistantcodes");
        if (MapUtils.isNotEmpty(saleassistantcodes)){

            // 查询当前billcode 下是否有营销助手码
            Map<String ,Object> billCodes = new HashMap<>();
            String billcode = MapUtils.getString(params ,"billcode");
            billCodes.put("billcode" ,billcode);
            List<Map<String, Object>> saleAssistantCodes = checkSaleassistantCodeExist(billCodes);

            // 如果没有，做更新操作  当前查询不为null 并且 当前查询的数据长度大于0  并且 当前查询的营销助手码是个空值
            if (null != saleAssistantCodes && saleAssistantCodes.size() != 0
                    && StringUtils.isBlank(MapUtils.getString(saleAssistantCodes.get(0),"saleassistantcode" ,""))){

                List<Map<String ,Object>> batchUpdateParams = new ArrayList<>();
                for (Map.Entry<String ,Object> entry : saleassistantcodes.entrySet()){
                    Map<String ,Object> batchUpdateParam = new HashMap<>();
                    batchUpdateParam.put("billcode" ,billcode);
                    batchUpdateParam.put("shopcode" ,entry.getKey());
                    batchUpdateParam.put("saleassistantcode" ,entry.getValue());
                    batchUpdateParams.add(batchUpdateParam);
                }
                dalClient.getDalClient().batchUpdate(NAME_SPACE + "batchUpdateSaleAssistantCodes" ,batchUpdateParams.toArray(new Map[batchUpdateParams.size()]));
            }
         }
    }

    private  List<Map<String, Object>> checkSaleassistantCodeExist(Map<String ,Object> billcode) {
        List<Map<String, Object>> saleAssistantCodes = dalClient.getReadOnlyDalClient().queryForList(NAME_SPACE + "checkSaleassistantCodeExist", billcode);
        return saleAssistantCodes;
    }

    private String saveOrderInfoByMerchant(Map<String, Object> params) throws ParseException {
        // 生成订单编号
        String servercode = MapUtils.getString(params, "servercode");
        String billcode = generateBillCode(servercode);
        params.put("billcode" ,billcode);

        // 解析商品信息
        Map<String, Object> orderInfo = JSONUtils.parseJsonObject(MapUtils.getString(params, "orderInfo"));

        // 查询服务商折扣
        Map<String ,Object> queryServerDiscountParams = new HashMap<>();
        queryServerDiscountParams.put("servercode" ,MapUtils.getString(params ,"servercode"));
        Map<String, Object> serverDiscount = queryServerDiscount(queryServerDiscountParams);

        // 生成item表信息
        orderInfo.put("billcode" ,billcode);
        orderInfo.putAll(serverDiscount);
        orderInfo.putAll(params);
        Map<String ,Object> mainInfo = new HashMap<>();
        List<Map<String, Object>> saveItems = saveItemInfo(mainInfo, orderInfo);
        // 生成内部支付code
        Map<String ,Object> generatorPayCodeParams = new HashMap<>();
        generatorPayCodeParams.put("servercode" ,servercode);
        generatorPayCodeParams.put("payamount" ,MapUtils.getString(mainInfo ,"totalamount"));
        generatorPayCodeParams.put("billcode" ,billcode);
        String payCode = generatorPayCode(generatorPayCodeParams);
        mainInfo.put("ordercode" ,payCode);

        saveMainInfo(mainInfo);

        // items
        List<Map<String, Object>> maps = setUpdateBranchExpiresTime(saveItems ,mainInfo);
        Map<String ,Object> updateParams = new HashMap<>();
        updateParams.put("items" ,maps);
        // 调用接口
        ZLRpcResult rpcResult = apitComponentService.addComponentOrder(updateParams);

        if (!rpcResult.success()){
            LOGGER.error("调用RPC保存订单信息异常!" ,rpcResult.getErrorMsg());
            throw new ServiceException("调用RPC保存订单信息异常!");
        }
        return payCode+","+billcode;
    }

    private List<Map<String,Object>> setUpdateBranchExpiresTime(List<Map<String, Object>> items ,Map<String ,Object> mainInfo) {
        List<Map<String ,Object>> result = new ArrayList<>();
        Map<String ,Object> branchItem = new HashMap<>();
        Map<String ,Map<String , Object>> shopMapData = new HashMap<>();
        for (Map<String ,Object> item : items){
            Map<String ,Object> shop = new HashMap<>(); // 用于存储订单信息
            List<Map<String ,Object>> branch = new ArrayList<>(); // 用于存储门店的
            String shopcode = MapUtils.getString(item ,"shopcode");
            if (shopMapData.containsKey(shopcode)){  // 判断是否存在，如果存在取出来存放下
                Map<String, Object> map = shopMapData.get(shopcode);
                branch = (List<Map<String ,Object>>)map.get("item");

                // 计算价格
                BigDecimal totalPrice = new BigDecimal(MapUtils.getString(map, "price"));
                BigDecimal totalPayPrice = new BigDecimal(MapUtils.getString(map, "payprice"));
                BigDecimal totalDiscountAmount = new BigDecimal(MapUtils.getString(map, "discountamount"));
                BigDecimal itemPrice = new BigDecimal(MapUtils.getString(item, "price"));
                BigDecimal itemPayPrice = new BigDecimal(MapUtils.getString(item, "payprice"));
                BigDecimal itemDiscountAmount = new BigDecimal(MapUtils.getString(item, "discountamount"));
                map.put("price" ,totalPrice.add(itemPrice));
                map.put("payprice" ,totalPayPrice.add(itemPayPrice));
                map.put("discountamount" ,totalDiscountAmount.add(itemDiscountAmount));
            }else{ // 不存在, 存进去
                shop.put("shopcode" ,shopcode);
                shop.put("shopname" ,MapUtils.getString(item,"shopname"));
                shop.put("billcode" ,MapUtils.getString(item,"billcode"));
                shop.put("servercode" ,MapUtils.getString(mainInfo,"servercode"));
                shop.put("servername" ,MapUtils.getString(mainInfo,"servername"));
                shop.put("productcode" ,MapUtils.getString(mainInfo,"productcode"));
                shop.put("productname" ,MapUtils.getString(mainInfo,"productname"));
                shop.put("ordercode" ,MapUtils.getString(mainInfo,"ordercode"));
                shop.put("price" ,MapUtils.getString(item,"price"));
                shop.put("payprice" ,MapUtils.getString(item,"payprice"));
                shop.put("discountamount" ,MapUtils.getString(item,"discountamount"));
                shop.put("item" ,branch); // 添加门店信息
                shopMapData.put(shopcode ,shop);
            }
            branch.add(item);  // 修改当前的
        }
        for (Map.Entry<String ,Map<String , Object>> entry : shopMapData.entrySet()){
            result.add(entry.getValue());
        }
        return result;
    }


    /**
     * 保存单据子表信息
     * @param mainInfo
     * @param orderInfo
     */
    private List<Map<String ,Object>> saveItemInfo(Map<String ,Object>  mainInfo ,Map<String, Object> orderInfo) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
        List<Map<String ,Object>> items = (List<Map<String ,Object>>)orderInfo.get("items");
        BigDecimal totalamount = new BigDecimal(0); // 单据总金额
        BigDecimal discountamount = new BigDecimal(0); // 优惠金额
        List<Map<String ,Object>> saveItems = new ArrayList<>();
        BigDecimal serverDiscount =  new BigDecimal(MapUtils.getString(orderInfo, "appdiscountratio"));
        for (Map<String ,Object> item : items){  // 遍历子表项
            // 查询商品信息
            Map<String ,Object> queryProductParams = new HashMap<>();
            queryProductParams.put("componentcode" ,MapUtils.getString(orderInfo ,"productcode"));
            String year=MapUtils.getString(item ,"renewtime","999");
            queryProductParams.put("year" ,year);
            Map<String ,Object> productInfo = queryComponentPriceByCodeYear(queryProductParams);
            orderInfo.putAll(productInfo);

            Map<String ,Object> saveItem = new HashMap<>();
            BigDecimal productprice = new BigDecimal(MapUtils.getString(orderInfo, "componentprice")); // 商品价格

            BigDecimal oldDiscount = new BigDecimal(MapUtils.getString(item, "discount"));
            if (oldDiscount.compareTo(serverDiscount) == -1){ // 填写的比原有的小
                oldDiscount = serverDiscount;
            }else if(oldDiscount.compareTo(new BigDecimal(100)) == 1){ // 比100大
                oldDiscount = new BigDecimal(100);
            }
            // 获取数量
            BigDecimal number = new BigDecimal(MapUtils.getString(item ,"number" ,"1"));
            BigDecimal discount = oldDiscount.divide(new BigDecimal(100));
            BigDecimal subamount = productprice.multiply(number).setScale(2 ,BigDecimal.ROUND_HALF_UP);
            BigDecimal price = productprice.multiply(discount).multiply(number).setScale(2 ,BigDecimal.ROUND_HALF_UP); // 单价 支付价格
            BigDecimal subdiscountamount = subamount.subtract(price); // 优惠金额

            totalamount = totalamount.add(price);
            discountamount = discountamount.add(subdiscountamount);

            setItemInfo(saveItem ,orderInfo,item ,subamount ,price ,simpleDateFormat);
            saveItems.add(saveItem);
        }
        setMainInfo(mainInfo , orderInfo ,totalamount ,discountamount); // 设置main表信息
        // 保存子表信息
        dalClient.getDalClient().batchUpdate(NAME_SPACE + "saveItemInfo", saveItems.toArray(new Map[saveItems.size()]));
        return saveItems;
    }

    private Map<String ,Object> queryComponentPriceByCodeYear(Map<String ,Object> params){
        ZLRpcResult rpcResult = apitComponentService.queryComponentPriceByCodeYear(params);
        ZLRpcResult rpcResult1=null;
        Map<String ,Object> productInfo = null;
        String  productcode= MapUtils.getString(params,"componentcode");
        if(productcode.equals("ZLRJ003")){
           // params.remove("year");
            rpcResult1 = apitComponentService.queryComponentPriceByCodeYear(params);
            if (rpcResult1.success()){
                productInfo =  (Map<String ,Object> )rpcResult1.getData();
            }
            return productInfo;
        } else {
            if (rpcResult.success()){
                productInfo =  (Map<String ,Object> )rpcResult.getData();
            }
            return productInfo;
        }

    }



    /**
     * 设置main表信息
     * @param mainInfo
     * @param orderInfo
     * @param totalamount
     * @param discountamount
     */
    private void setMainInfo(Map<String ,Object> mainInfo ,Map<String ,Object> orderInfo ,BigDecimal totalamount ,BigDecimal discountamount){
        mainInfo.put("servercode",MapUtils.getString(orderInfo ,"servercode"));
        mainInfo.put("servername",MapUtils.getString(orderInfo ,"servername"));
        mainInfo.put("billcode",MapUtils.getString(orderInfo ,"billcode"));
        mainInfo.put("ordercode",MapUtils.getString(orderInfo ,"ordercode"));
        mainInfo.put("productcode",MapUtils.getString(orderInfo ,"componentcode"));
        mainInfo.put("productname",MapUtils.getString(orderInfo ,"componentname"));
        mainInfo.put("totalamount",totalamount);
        mainInfo.put("discountamount",discountamount);
        mainInfo.put("status","0");
        mainInfo.put("type",MapUtils.getString(orderInfo ,"type"));
        mainInfo.put("billtype","0");
        mainInfo.put("createuser",MapUtils.getString(orderInfo ,"loginuserid"));
        mainInfo.put("createusername",MapUtils.getString(orderInfo ,"loginuserfullname"));
        mainInfo.put("del","0");
    }

    /**
     * 设置子表信息
     * @param saveItem
     * @param orderInfo
     * @param item
     * @param price
     * @param simpleDateFormat
     * @throws ParseException
     */
    private void setItemInfo(Map<String ,Object> saveItem ,Map<String, Object> orderInfo ,Map<String ,Object> item ,BigDecimal subamount, BigDecimal price ,SimpleDateFormat simpleDateFormat) throws ParseException {
        // 设置item参数
        saveItem.put("billcode" ,MapUtils.getString(orderInfo ,"billcode"));
        saveItem.put("shopcode" ,MapUtils.getString(item ,"shopcode"));
        saveItem.put("shopname" ,MapUtils.getString(item ,"shopname"));
        saveItem.put("branchcode" ,MapUtils.getString(item ,"branchcode"));
        saveItem.put("branchname" ,MapUtils.getString(item ,"branchname"));
        saveItem.put("productcode" ,MapUtils.getString(orderInfo ,"componentcode"));
        saveItem.put("productname" ,MapUtils.getString(orderInfo ,"componentname"));
        saveItem.put("price" ,subamount);
        saveItem.put("saleassistantcode" ,MapUtils.getString(item ,"saleassistantcode"));
        saveItem.put("payprice" ,price);
        saveItem.put("discountamount" ,subamount.subtract(price));
        saveItem.put("num" ,MapUtils.getIntValue(item ,"number" ,1));
        saveItem.put("discount" ,MapUtils.getString(item, "discount"));
        String expiretime = MapUtils.getString(item, "expirestime");
        LOGGER.info("到期时间:{}" ,expiretime);
        if (StringUtils.isNotBlank(expiretime)){
            saveItem.put("preexpiretime" ,expiretime);
        }else{
            saveItem.put("preexpiretime" ,simpleDateFormat.format(new Date()));
        }
        String type = MapUtils.getString(orderInfo, "type");
        if (true){
            saveItem.put("renewtime" ,MapUtils.getString(item, "renewtime"));
            //  计算日期
            Date preexpiretime = new Date();
            if (StringUtils.isNotBlank(expiretime)){
                preexpiretime = simpleDateFormat.parse(expiretime);
            }
            if (preexpiretime.before(new Date())){
                preexpiretime = new Date();
            }
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(preexpiretime);
            calendar.add(Calendar.YEAR ,MapUtils.getIntValue(item ,"renewtime"));
            saveItem.put("sufexpiretime" ,simpleDateFormat.format(calendar.getTime()));
        }
    }

    /**
     * 保存主表信息
     * @param mainInfo
     */
    private void saveMainInfo(Map<String ,Object>  mainInfo){
        dalClient.getDalClient().execute(NAME_SPACE + "saveMainInfo" ,mainInfo);
    }


    private String generateBillCode(String servercode){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        Map<String, Object> params = new HashMap<>();
        params.put("servercode" ,servercode);
        StringBuilder code = new StringBuilder();
        code.append("XF").append(servercode).append("-").append(simpleDateFormat.format(new Date())).append("-");
        // 统计服务商当前订单数量
        Integer integer = dalClient.getReadOnlyDalClient().queryForObject(NAME_SPACE + "generateBillCode", params, Integer.class);
        Integer auto = 1000 + integer + 1;
        code.append(String.valueOf(auto).substring(1));
        return code.toString();
    }

    private String generatorPayCode(Map<String ,Object> params){
        Map<String ,Object> payCodeParams = new HashMap<>();
        payCodeParams.put("businesscode" ,MapUtils.getString(params, "billcode"));
        payCodeParams.put("shopcode" ,MapUtils.getString(params, "servercode"));
        payCodeParams.put("businessorigin" ,"srvms-serverRecharge");
        payCodeParams.put("payamount" ,MapUtils.getString(params, "payamount"));
        ZLRpcResult result = apiPaysOrderService.prePayOrder(payCodeParams);
        if (null != result && result.success()){
            return result.getData().toString();
        }
        return  null;
    }

    /**
     * 查询服务商折扣价格
     * @param params
     * @return
     */
    public Map<String ,Object> queryServerDiscount(Map<String ,Object> params){
        return srvUserService.queryServerDiscount(params);
    }



    public Map<String, Object> queryProductInfoDetail(Map<String, Object> productCode) {
        ZLRpcResult rpcResult = apitComponentService.queryComponentPriceByCode(productCode);
        if (rpcResult.success()){
            return  ( Map<String, Object>)rpcResult.getData();
        }
        return null;
    }

    @Override
    public List<Map<String, Object>> queryPayOrderInfoByBillCode(Map<String, Object> params) {
       return  dalClient.getDalClient().queryForList(NAME_SPACE + "queryOrderInfoByBillCode", params); // 不能使用ReadOnly
    }

    public void updateRenewStatusByProductCode(Map<String, Object> params) {
        int execute = dalClient.getDalClient().execute(NAME_SPACE + "updateRenewStatusByProductCode", params);
    }

    private Map<String ,Object> querywechatPriceByCodeYear(Map<String ,Object> params){
        ZLRpcResult rpcResult = apitComponentService.queryComponentPriceByCode(params);
        Map<String ,Object> productInfo = null;
        if (rpcResult.success()){
            productInfo =  (Map<String ,Object> )rpcResult.getData();
        }
        return productInfo;
    }

    public List<Map<String, Object>> savewechatOrderInfoByBillCode(Map<String, Object> params) throws ParseException {
        if (StringUtils.isBlank(MapUtils.getString(params ,"billcode"))){
            // 生成单据
            savewechatOrderInfoByMerchant(params);
        }
        return  dalClient.getDalClient().queryForList(NAME_SPACE + "queryOrderInfoByBillCode", params); // 不能使用ReadOnly
    }

    private void savewechatOrderInfoByMerchant(Map<String, Object> params) throws ParseException {
        // 生成订单编号
        String servercode = MapUtils.getString(params, "servercode");
        String billcode = generateBillCode(servercode);
        params.put("billcode" ,billcode);

        // 解析商品信息
        Map<String, Object> orderInfo = JSONUtils.parseJsonObject(MapUtils.getString(params, "orderInfo"));

        // 查询服务商折扣
        Map<String ,Object> queryServerDiscountParams = new HashMap<>();
        queryServerDiscountParams.put("servercode" ,MapUtils.getString(params ,"servercode"));
        Map<String, Object> serverDiscount = queryServerDiscount(queryServerDiscountParams);

        // 生成item表信息
        orderInfo.put("billcode" ,billcode);
        orderInfo.putAll(serverDiscount);
        orderInfo.putAll(params);
        Map<String ,Object> mainInfo = new HashMap<>();

        savewechatItemInfo(mainInfo ,orderInfo);
        // 生成内部支付code
        Map<String ,Object> generatorPayCodeParams = new HashMap<>();
        generatorPayCodeParams.put("servercode" ,servercode);
        generatorPayCodeParams.put("payamount" ,MapUtils.getString(mainInfo ,"totalamount"));
        generatorPayCodeParams.put("billcode" ,billcode);
        String payCode = generatorPayCode(generatorPayCodeParams);
        mainInfo.put("ordercode" ,payCode);

        saveMainInfo(mainInfo);

    }
    private void savewechatItemInfo(Map<String ,Object>  mainInfo ,Map<String, Object> orderInfo) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
        List<Map<String ,Object>> items = (List<Map<String ,Object>>)orderInfo.get("items");
        BigDecimal totalamount = new BigDecimal(0); // 单据总金额
        BigDecimal discountamount = new BigDecimal(0); // 优惠金额
        List<Map<String ,Object>> saveItems = new ArrayList<>();
        BigDecimal serverDiscount =  new BigDecimal(MapUtils.getString(orderInfo, "appdiscountratio"));
        for (Map<String ,Object> item : items){  // 遍历子表项
            // 查询商品信息
            Map<String ,Object> queryProductParams = new HashMap<>();
            queryProductParams.put("productcode" ,MapUtils.getString(orderInfo ,"productcode"));
            queryProductParams.put("renewtime" ,MapUtils.getString(orderInfo ,"renewtime","1"));
            Map<String ,Object> productInfo = queryComponentPriceByCodeYear(queryProductParams);
            orderInfo.putAll(productInfo);

            Map<String ,Object> saveItem = new HashMap<>();
            BigDecimal productprice = new BigDecimal(MapUtils.getString(orderInfo, "productprice")); // 商品价格

            BigDecimal oldDiscount = new BigDecimal(MapUtils.getString(item, "discount"));
            if (oldDiscount.compareTo(serverDiscount) == -1){ // 填写的比原有的小
                oldDiscount = serverDiscount;
            }else if(oldDiscount.compareTo(new BigDecimal(100)) == 1){ // 比100大
                oldDiscount = new BigDecimal(100);
            }
            BigDecimal discount = oldDiscount.divide(new BigDecimal(100));
            BigDecimal price = productprice.multiply(discount); // 单价 支付价格
            BigDecimal subdiscountamount = productprice.subtract(price); // 优惠金额

            totalamount = totalamount.add(price);
            discountamount = discountamount.add(subdiscountamount);

            setItemInfo(saveItem ,orderInfo,item ,productprice ,price ,simpleDateFormat);
            saveItems.add(saveItem);
        }
        setMainInfo(mainInfo , orderInfo ,totalamount ,discountamount); // 设置main表信息
        // 保存子表信息
        dalClient.getDalClient().batchUpdate(NAME_SPACE + "saveItemInfo", saveItems.toArray(new Map[saveItems.size()]));
    }

    /**
     * 根据id查询营销助手码
     * @param params
     * @return
     */
    @Override
    public Map<String, Object> querysaleassistantcode(Map<String, Object> params) {
        return  dalClient.getDalClient().queryForMap(NAME_SPACE + "querysAleassistantcodeById", params);
    }
}
