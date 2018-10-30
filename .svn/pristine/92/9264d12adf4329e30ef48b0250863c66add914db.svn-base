package com.wgb.service.impl.renew;

import com.sun.corba.se.spi.ior.ObjectKey;
import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.urms.web.ApitBranchService;
import com.wgb.service.renew.ExtendService;
import com.wgb.util.JSONUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sun.awt.image.ShortComponentRaster;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商户延期
 */
@Service
public class ExtendServiceImpl implements ExtendService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ExtendServiceImpl.class);

    private static final String NAME_SPACE = "shardName.com.wgb.service.impl.renew.RenewServiceImpl.";

    @Autowired
    private CommonDalClient dalClient;

    @Autowired
    private ApitBranchService apitBranchService;

    @Override
    public Page queryExtendInfoByCondition(Map<String, Object> params) {
        return dalClient.getReadOnlyDalClient().queryForListPage(NAME_SPACE + "queryExtendInfoByCondition", params);
    }

    public void saveExtendInfo(Map<String, Object> params) throws ParseException {
        // 生成订单ID
        String billcode = generateExtendBillCode(MapUtils.getString(params ,"servercode"));
        params.put("billcode" ,billcode);
        HashMap<String ,Object> mainInfo = new HashMap<>();
        List<Map<String, Object>> items = saveItemInfo(mainInfo, params);
        saveMainInfo(mainInfo);
        // items
        List<Map<String ,Object>> updateBranchExpires = setUpdateBranchExpiresTime(items ,mainInfo);
        Map<String ,Object> updateParams = new HashMap<>();
        updateParams.put("items" ,updateBranchExpires);
        // 调用接口
        ZLRpcResult rpcResult = apitBranchService.updateBranchExpirestimeForSalver(updateParams);
        if (!rpcResult.success()){
            LOGGER.error("调用RPC保存订单信息异常!" ,rpcResult.getErrorMsg());
            throw new ServiceException("调用RPC保存订单信息异常!");
        }

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
                branch = (List<Map<String ,Object>>)shopMapData.get(shopcode).get("item");
            }else{ // 不存在, 存进去
                shop.put("shopcode" ,shopcode);
                shop.put("shopname" ,MapUtils.getString(item,"shopname"));
                shop.put("billcode" ,MapUtils.getString(item,"billcode"));
                shop.put("servercode" ,MapUtils.getString(mainInfo,"servercode"));
                shop.put("servername" ,MapUtils.getString(mainInfo,"servername"));
                shop.put("productcode" ,MapUtils.getString(mainInfo,"productcode"));
                shop.put("productname" ,MapUtils.getString(mainInfo,"productname"));
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

    public List<Map<String, Object>> queryExtendDetail(Map<String, Object> params) {
        return  dalClient.getReadOnlyDalClient().queryForList(NAME_SPACE + "queryExtendDetail" ,params);
    }

    private void saveMainInfo(HashMap<String, Object> mainInfo){
        dalClient.getDalClient().execute(NAME_SPACE + "saveMainInfo" ,mainInfo);
    }

    private  List<Map<String ,Object>> saveItemInfo(HashMap <String, Object> mainInfo, Map<String, Object> params) throws ParseException {
        Map<String, Object> extendInfo = JSONUtils.parseJsonObject(MapUtils.getString(params, "extendInfo"));
        extendInfo.putAll(params);
        List<Map<String ,Object>> saveInfos = new ArrayList<>();
        List<Map<String ,Object>> items = (List<Map<String ,Object>>)extendInfo.get("items");
        for (Map<String ,Object> item : items){  // 遍历子表项
            Map<String ,Object> saveInfo = new HashMap<>();
            Map<String ,Object> saveItem = new HashMap<>();
            setItemInfo(saveInfo,extendInfo ,item);
            saveInfos.add(saveInfo);
        }
        setMainInfo(mainInfo, extendInfo); // 设置main表信息
        // 保存子表信息
        dalClient.getDalClient().batchUpdate(NAME_SPACE + "saveItemInfo", saveInfos.toArray(new Map[saveInfos.size()]));
        return saveInfos;
    }

    private void setMainInfo(Map<String ,Object> mainInfo ,Map<String ,Object> extendInfo ){
        mainInfo.put("servercode",MapUtils.getString(extendInfo ,"servercode"));
        mainInfo.put("servername",MapUtils.getString(extendInfo ,"servername"));
        mainInfo.put("billcode",MapUtils.getString(extendInfo ,"billcode"));
        mainInfo.put("remark",MapUtils.getString(extendInfo ,"remark"));
        mainInfo.put("ordercode","yq1111");
        mainInfo.put("productcode",MapUtils.getString(extendInfo ,"productcode"));
        mainInfo.put("productname",MapUtils.getString(extendInfo ,"productcode").equals("0")?"商户后台-标准版":"商户后台-连锁版");
        mainInfo.put("totalamount", 0);
        mainInfo.put("discountamount",0);
        mainInfo.put("status","1");
        mainInfo.put("type",MapUtils.getString(extendInfo ,"productcode").equals("0")?"0":"1");
        mainInfo.put("billtype","1");
        mainInfo.put("createuser",MapUtils.getString(extendInfo ,"loginuserid"));
        mainInfo.put("createusername",MapUtils.getString(extendInfo ,"loginuserfullname"));
        mainInfo.put("del","0");
    }

    private void setItemInfo(Map<String, Object> saveInfo ,Map<String, Object> extendInfo,Map<String ,Object> item ) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // 设置item参数
        saveInfo.put("billcode" ,MapUtils.getString(extendInfo ,"billcode"));
        saveInfo.put("shopcode" ,MapUtils.getString(item ,"shopcode"));
        saveInfo.put("shopname" ,MapUtils.getString(item ,"shopname"));
        saveInfo.put("branchcode" ,MapUtils.getString(item ,"branchcode"));
        saveInfo.put("branchname" ,MapUtils.getString(item ,"branchname"));
        saveInfo.put("productcode" ,MapUtils.getString(extendInfo ,"productcode"));
        saveInfo.put("productname" ,MapUtils.getString(extendInfo ,"productcode").equals("single")?"商户后台-标准版":"商户后台-连锁版");
        saveInfo.put("price" ,0);
        saveInfo.put("payprice" ,0);
        saveInfo.put("discountamount" ,0);
        saveInfo.put("num" ,1);
        saveInfo.put("discount" ,100);
        saveInfo.put("preexpiretime" ,MapUtils.getString(item, "expirestime"));
        saveInfo.put("renewtime" ,7);
        //  计算日期
        String time=MapUtils.getString(item, "expirestime");
        Date preexpiretime = simpleDateFormat.parse(time);
        if (preexpiretime.before(new Date())){
            preexpiretime = new Date();
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(preexpiretime);
        calendar.add(Calendar.DAY_OF_YEAR ,MapUtils.getIntValue(saveInfo ,"renewtime"));
        saveInfo.put("sufexpiretime" ,simpleDateFormat.format(calendar.getTime()));
    }

    private String generateExtendBillCode(String servercode){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        Map<String, Object> params = new HashMap<>();
        params.put("servercode" ,servercode);
        StringBuilder code = new StringBuilder();
        code.append("YQ").append(servercode).append("-").append(simpleDateFormat.format(new Date())).append("-");
        // 统计服务商当前订单数量
        Integer integer = dalClient.getReadOnlyDalClient().queryForObject(NAME_SPACE + "generateExtendBillCode", params, Integer.class);
        Integer auto = 1000 + integer + 1;
        code.append(String.valueOf(auto).substring(1));
        return code.toString();
    }
}
