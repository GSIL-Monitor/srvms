package com.wgb.service.impl.srv;

import com.alibaba.fastjson.JSON;
import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.urms.admin.ApiBranchService;
import com.wgb.service.srv.SrvRenewService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.Contants;
import com.wgb.util.JSONUtils;
import com.wgb.util.OrderCodeBuilderUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.xalan.xsltc.compiler.util.ResultTreeType;
import org.omg.CORBA.OBJ_ADAPTER;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class SrvRenewServiceImpl implements SrvRenewService{

    private static final Logger LOGGER = LoggerFactory.getLogger(SrvRenewServiceImpl.class);
    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.SrvRenewServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Autowired
    private ApiBranchService apiBranchService;

    @Autowired
    private SrvShopService srvShopService;

    public List<Object> saveBranchRenew(Map<String, Object> params) {
        // 保存服务商订单信息
        List<Object> result = saveServerOrderInfo(params);
        // 调用api保存商户订单信息
        saveShopOrderInfo(result);
        return result;
    }

    /**
     * 保存商户订单信息
     * @param params
     */
    private void saveShopOrderInfo(List<Object> params){
        // 获取参数
        Map<String, Object> result = parseShopOrderInfo(params);
        apiBranchService.insertRechargeOrderMain(result);
    }

    private Map<String,Object> parseShopOrderInfo(List<Object> params){
        Map<String ,Object>  orderMainInfos = (Map<String ,Object>)params.get(0);
        List<Map<String ,Object>> orderItemInfos = (List<Map<String ,Object>>)params.get(1);
        Map<String, Object> result =  setShopOrderInfo(orderMainInfos,orderItemInfos);
        return result;
    }

    /**
     *  设置 商户订单信息
     * @param orderMainInfos
     * @param orderItemInfos
     * @return
     */
    private Map<String,Object> setShopOrderInfo(Map<String, Object> orderMainInfos, List<Map<String, Object>> orderItemInfos) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Map<String,Object> result = new HashMap<>();
        result.put("shopcode",orderMainInfos.get("shopCode"));
        result.put("createtime",simpleDateFormat.format(new Date()));
        result.put("saletime",new Date());
        result.put("createuser",orderMainInfos.get("createuser"));
        result.put("totalamount",orderMainInfos.get("totalPrice"));
        result.put("billstatus",orderMainInfos.get("payStatus"));
        result.put("billcode",orderMainInfos.get("orderCode"));
        result.put("createusername",orderMainInfos.get("createuser"));
        result.put("costprice",orderMainInfos.get("totalPrice"));

        List<Map<String, Object>> branchInfos = new ArrayList<>();
        int sumyear = 0;
        boolean flag = true;
        for(Map<String, Object> orderItemInfo : orderItemInfos){
            Map<String, Object> branchInofo = new HashMap<>();
            branchInofo.put("branchcode",orderItemInfo.get("branchcode"));
            branchInofo.put("branchname",orderItemInfo.get("branchname"));
            sumyear += Integer.parseInt(orderItemInfo.get("renewtime").toString());
            branchInofo.put("preexpiretime", simpleDateFormat.format((Date) orderItemInfo.get("preexpiretime")));
            branchInofo.put("suffexpiretime", simpleDateFormat.format((Date)orderItemInfo.get("sufexpiretime")));
            branchInofo.put("expirestyear",MapUtils.getString(orderItemInfo,"renewtime"));
            branchInofo.put("shopcode",orderMainInfos.get("shopCode"));
            branchInofo.put("totalamount",orderItemInfo.get("totalamount"));
            branchInofo.put("servercode",MapUtils.getString(orderMainInfos,"serverCode"));
            if(flag){
                flag = false;
                result.put("price",MapUtils.getString(orderItemInfo,"amount"));
                if(StringUtils.isNotBlank(MapUtils.getString(orderItemInfo,"invoiceconsignee"))){
                    result.put("isbill","2");
                    result.put("consignee",orderItemInfo.get("invoiceconsignee"));
                    result.put("tel",orderItemInfo.get("invoicetel"));
                    result.put("billtitle",orderItemInfo.get("invoicetitle"));
                    result.put("taxpayernumber",orderItemInfo.get("taxpayerid"));
                    result.put("profile",orderItemInfo.get("receivingadd"));
                }else{
                    result.put("isbill","1");
                    result.put("consignee",null);
                    result.put("tel",null);
                    result.put("billtitle",null);
                    result.put("taxpayernumber",null);
                    result.put("profile",null);
                }
            }
            branchInfos.add(branchInofo);
        }
        result.put("branchinfo",branchInfos);
        result.put("sumyear",sumyear);
        return result;
    }

    /**
     * 保存服务商订单信息
     * @param params
     * @return
     */
    private List<Object> saveServerOrderInfo(Map<String, Object> params){
        List<Object> result = new ArrayList<>();
        // 生成订单编号
        String orderCode = OrderCodeBuilderUtils.generationOrderCode(MapUtils.getString(params,"servercode"));
        BigDecimal productPrice = queryProductPrice(params);
        // 设置订单项表信息
        List<Map<String ,Object>> inserOrderIntemParams = new ArrayList<>();
        BigDecimal totalPrice = setInsertOrderIntemParams(inserOrderIntemParams, params, orderCode, productPrice);
        // 设置订单表信息
        Map<String ,Object> inserOrderMainParams = new HashMap<>();
        setInsertOrderMainParams(inserOrderMainParams,params,orderCode,totalPrice);
        // 插入表单信息
        dal.getDalClient().execute(NAMESPACE + "saveOrderMain",inserOrderMainParams);
        dal.getDalClient().batchUpdate(NAMESPACE + "saveOrderItem", inserOrderIntemParams.toArray(new Map[inserOrderIntemParams.size()]));
        result.add(inserOrderMainParams);
        result.add(inserOrderIntemParams);
        return result;
    }

    /**
     * 查询商品价格
     * @param params
     * @return
     */
    private BigDecimal queryProductPrice(Map<String, Object> params){
        // 查询商品价格
        List<Map<String,Object>> productInfo = srvShopService.queryProductInfo(params);
        BigDecimal productPrice = new BigDecimal(0);
        if(CollectionUtils.isNotEmpty(productInfo)){
            String content = MapUtils.getString(productInfo.get(0), "content");
            if(StringUtils.isNotBlank(content)){
                return new BigDecimal(content);
            }
        }
        return null;
    }

    public Page<?> queryRenewBranchView(Map<String, Object> params) {

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.DAY_OF_YEAR ,-2);

        params.put("timeout" ,calendar.getTime());

        // 修改订单状态
        dal.getDalClient().execute(NAMESPACE + "updateRenewPayStatus" ,params);

        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryRenewBranchView", params);
    }


    public String deleteOrderByOrderId(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "deleteOrderMainByOrderId", params);
        dal.getDalClient().execute(NAMESPACE + "deleteOrderItemByOrderId", params);
        return "";
    }

    public List<Map<String, Object>> queryOrderMainDetailByOrderId(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryOrderMainDetailByOrderId", params);
    }

    public List<Map<String, Object>> queryOrderItemDetailByOrderId(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryOrderItemDetailByOrderId", params);
    }

    public Map<String, Object> queryOrderInfoByCondition(Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        // 查询主表信息
        List<Map<String, Object>> orderMainInfos = queryOrderMainByCondition(params);
        List<Map<String, Object>> orderItemInfos = queryOrderItemByCondition(params);
        result.put("inserOrderMain", orderMainInfos.isEmpty() ? null : orderMainInfos.get(0));
        result.put("inserOrderItem",orderItemInfos);
        if(!orderItemInfos.isEmpty()){
            result.put("productname",(orderItemInfos.get(0).get("productname")));
        }else{
            result.put("productname",null);
        }
        return result;
    }

    public String extendProbation(Map<String, Object> params) {
        String branchcodes = MapUtils.getString(params, "branchcodes");
        if(StringUtils.isNotBlank(branchcodes)){
            String[] split = branchcodes.split(",");
            List<String> branchcode = Arrays.asList(split);
            params.put("branchcode" , branchcode);
        }
        ZLRpcResult rpcResult = apiBranchService.extendBranch(params);
        return  rpcResult.getErrorMsg();
    }

    public String checkExtendProbationCondition(Map<String, Object> params) {
        try {
            String branchcodes = MapUtils.getString(params, "branchcodes");
            String[] split = branchcodes.split(",");
            params.put("branchcodes" ,Arrays.asList(split));
            LOGGER.info("查询门店是否可延期入参：" + params);
            ZLRpcResult result = apiBranchService.queryExtendBranchs(params);
            LOGGER.info("查询门店是否可延期出参：" + JSON.toJSONString(result));
            StringBuilder resultMessage = new StringBuilder();
            if (result.success()) {
                if (null != result.getList() && result.getList().size() > 0) {
                    resultMessage.append("门店");
                    List<Map<String, Object>> list = result.getList();
                    for (Map<String, Object> branchMap : list) {
                        resultMessage.append(branchMap.get("branchcode")).append(",");
                    }
                    resultMessage.append("已延期！现不能继续延期！是否延期其他门店？");
                }
            }else {
                resultMessage.append(result.getErrorMsg());
            }

            return resultMessage.toString();
        }catch (Exception e){
            LOGGER.error("查询门店是否延期失败!" ,e);
            return "操作异常!请联系管理员!!";
        }
    }

    /**
     * 根据条件查询订单信息
     * @param params
     * @return
     */
    private List<Map<String, Object>> queryOrderMainByCondition(Map<String, Object> params){
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryOrderMainByCondition" , params);
    }

    /**
     * 根据条件查询订单信息
     * @param params
     * @return
     */
    private List<Map<String, Object>> queryOrderItemByCondition(Map<String, Object> params){
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryOrderItemByCondition" , params);
    }

    /**
     * 设置参数
     * @param inserOrderIntemParams
     *          空参
     * @param params
     *          参数值，包含branchList
     * @param orderCode
     *          订单编号
     * @param productPrice
     *          商品单价
     * @return
     */
    private BigDecimal setInsertOrderIntemParams(List<Map<String, Object>> inserOrderIntemParams, Map<String, Object> params, String orderCode, BigDecimal productPrice) {
        String branchList = MapUtils.getString(params, "branchList");
        BigDecimal totalAmount = new BigDecimal(0);
        List<Object> branchLists = JSONUtils.parseJsonArray(branchList);
        for (Object obj : branchLists){
            Map<String, Object> branchInfo = (Map<String, Object>)obj;
            if(null != branchInfo && branchInfo.size() > 0 && branchInfo.containsKey("expirestyear")){
                Map<String ,Object> inserOrderIntemMap = new HashMap<>();
                BigDecimal subTotalAmount = setInsertOrderIntemParamsProperty(inserOrderIntemMap, branchInfo, params, orderCode, productPrice );
                totalAmount = totalAmount.add(subTotalAmount);
                inserOrderIntemParams.add(inserOrderIntemMap);
            }
        }
        return totalAmount;
    }

    /**
     * 设置属性
     * @param inserOrderIntemMap
     *      空参
     * @param branchInfo
     *      页面传值
     * @param params
     *      页面传值
     * @param orderCode
     *      订单编号
     * @param productPrice
     *      商品价格
     * @return
     */
    private BigDecimal setInsertOrderIntemParamsProperty( Map<String ,Object> inserOrderIntemMap, Map<String, Object> branchInfo, Map<String, Object> params, String orderCode, BigDecimal productPrice){
        try {
            Integer expirestyear =  MapUtils.getInteger(branchInfo, "expirestyear");
            List<Map<String, Object>> branchAllInfos = queryBranchInfoByBranchCodeAndShopCode(params,branchInfo);

           if(CollectionUtils.isEmpty(branchAllInfos)){
               LOGGER.error("SrvRenewServiceImpl.setInsertOrderIntemParamsProperty 未查到询商户信息！");
               // 自定义异常
               throw new RuntimeException("SrvRenewServiceImpl.setInsertOrderIntemParamsProperty 未查到询商户信息！");
           }
            Map<String, Object> branchAllInfo = branchAllInfos.get(0);;
            BigDecimal subTotalAmount = calculateAmount(expirestyear,productPrice); // 计算单据价格

            inserOrderIntemMap.put("orderid",orderCode); // 订单ID
            inserOrderIntemMap.put("totalamount",subTotalAmount); // 单据总价格
            inserOrderIntemMap.put("amount",productPrice); // 单价
            inserOrderIntemMap.put("productname",MapUtils.getString(params,"productname")); // 商品名称
            inserOrderIntemMap.put("createuser",MapUtils.getString(params,Contants.LOGIN_USER_ID)); // 创建人
            inserOrderIntemMap.put("valid",1); // 是否有效
            inserOrderIntemMap.put("branchcode",MapUtils.getString(branchAllInfo, "branchcode")); // 门店编号
            inserOrderIntemMap.put("branchname",MapUtils.getString(branchAllInfo, "branchname")); // 门店名称
            inserOrderIntemMap.put("renewtime",expirestyear); // 续费年限
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date preExpirestime = simpleDateFormat.parse(MapUtils.getString(branchAllInfo,"expirestime"));
            // 计算年限
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(preExpirestime);
            calendar.add(Calendar.YEAR,expirestyear);
            inserOrderIntemMap.put("preexpiretime",preExpirestime); // 之前到期时间
            inserOrderIntemMap.put("sufexpiretime",calendar.getTime()); // 之后到期时间
            inserOrderIntemMap.put("invoiceconsignee",MapUtils.getString(params, "invoiceconsignee")); // 发票收货人
            inserOrderIntemMap.put("invoicetitle",MapUtils.getString(params, "invoicetitle")); // 发票抬头
            inserOrderIntemMap.put("taxpayerid",MapUtils.getString(params, "taxpayerid")); // 纳税人识别号
            inserOrderIntemMap.put("invoicetel",MapUtils.getString(params, "invoicetel")); // 联系人电话
            inserOrderIntemMap.put("receivingadd",MapUtils.getString(params, "receivingadd")); // 收件人地址
            return subTotalAmount;
        }catch (ParseException e) {
           LOGGER.error("解析到期时间异常!",e);
           new RuntimeException("解析到期时间异常!",e);
        }
        return null;
    }

    /**
     * 根据ShopCode 和 BranchCode查询商户信息
     * @param params
     *      shopcode
     *      branchcode
     * @return
     */
    private List<Map<String, Object>> queryBranchInfoByBranchCodeAndShopCode(Map<String ,Object> params,Map<String, Object> branchInfo){
        List<Map<String, Object>> result = null;
        try {
            Map<String, Object> queryBranchInfoParams = new HashMap<>();
            queryBranchInfoParams.put("shopcode",MapUtils.getString(params, "shopcode"));
            queryBranchInfoParams.put("branchcode",MapUtils.getString(branchInfo, "branchcode"));
            LOGGER.info(String.format("SrvRenewServiceImpl.queryBranchInfoByBranchCodeAndShopCode 查询商户信息入参：%s",queryBranchInfoParams.toString()));
            ZLRpcResult rpcResult = apiBranchService.queryBranchDefaultdistpricetypeDetail(queryBranchInfoParams);
           if(rpcResult.success()){
               result = rpcResult.getList();
               LOGGER.info(String.format("SrvRenewServiceImpl.queryBranchInfoByBranchCodeAndShopCode 查询商户信息出参：%s", JSON.toJSONString(result)));
           }else {
               LOGGER.error("SrvRenewServiceImpl.queryBranchInfoByBranchCodeAndShopCode 未查到询商户信息！");
               // 自定义异常
               throw new RuntimeException("SrvRenewServiceImpl.queryBranchInfoByBranchCodeAndShopCode 未查到询商户信息！");
           }
        } catch (Exception e) {
            LOGGER.error("SrvRenewServiceImpl.queryBranchInfoByBranchCodeAndShopCode 查询商户信息出错！",e);
            // 自定义异常
            throw new RuntimeException("SrvRenewServiceImpl.queryBranchInfoByBranchCodeAndShopCode 查询商户信息出错！",e);
        }
        return  result;
    }

    /**
     * 计算价格，暂时时这样计算
     * @param expirestyear
     *          购买年限
     * @param productPrice
     *          年限单价
     * @return
     */
    private BigDecimal calculateAmount(Integer expirestyear, BigDecimal productPrice){
        return productPrice.multiply(new BigDecimal(expirestyear));
    }

    /**
     * 设置订单表信息
     * @param inserOrderMainParams
     *         空参
     * @param params
     *          需保存信息
     * @param orderCode
     *          订单编号
     * @param totalPrice
     *          订单总价格
     */
    private void setInsertOrderMainParams( Map<String ,Object> inserOrderMainParams,Map<String, Object> params,String orderCode, BigDecimal totalPrice){
        inserOrderMainParams.put("orderCode",orderCode);  //
        inserOrderMainParams.put("shopCode",MapUtils.getString(params,"shopcode"));
        inserOrderMainParams.put("shopName",MapUtils.getString(params,"shopname"));
        inserOrderMainParams.put("serverCode",MapUtils.getString(params, Contants.LOGIN_USER_SERVER_CODE));
        inserOrderMainParams.put("serverName",MapUtils.getString(params, Contants.LOGIN_USER_SERVER_NAME));
        inserOrderMainParams.put("orderType",0);
        inserOrderMainParams.put("payStatus",0);
        inserOrderMainParams.put("valid",1);
        inserOrderMainParams.put("createuser",MapUtils.getString(params, Contants.LOGIN_USER_FULL_NAME));
        inserOrderMainParams.put("totalPrice",totalPrice);
    }
}

