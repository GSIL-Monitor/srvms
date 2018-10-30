package com.wgb.service.impl.equipmonitor;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.bugms.admin.ApiEquipMonitorService;
import com.wgb.service.equipmonitor.EquipMonitorService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 14:33
 **/
@Service
public class EquipMonitorServiceImpl implements EquipMonitorService {

    @Autowired
    private ApiEquipMonitorService apiEquipMonitorService;

    @Autowired
    private SrvShopService srvShopService;

    @Override
    public Map<String, Object> queryFaultDetect(Map<String, Object> params) {
        Map<String ,Object> resultMap = new HashMap<>();
        List<Map<String, Object>> shopList = srvShopService.getSrvShopList(params);
        if (CollectionUtils.isNotEmpty(shopList)) {
            List<String> shopcodeList = CommonUtil.getListStringFromListMap(shopList, "shopcode");
            params.put("shopcodelist", shopcodeList);
            //查询列表
            ZLRpcResult pageInfo = apiEquipMonitorService.queryShopPageList(params);
            //查询统计数据--未处理、处理、待处理 故障数
            ZLRpcResult rpcResult = apiEquipMonitorService.queryShopAnalysis(params);
            if (pageInfo.success()){
                resultMap.put("pageInfo", pageInfo.getData());
            }
            if (rpcResult.success()){
                Map<String, Object> rpcResultMap = rpcResult.getMap();
                resultMap.put("deallater", MapUtils.getString(rpcResultMap, "deallater", "0"));
                resultMap.put("waitdeal", MapUtils.getString(rpcResultMap, "waitdeal", "0"));
                resultMap.put("dealing", MapUtils.getString(rpcResultMap, "dealing", "0"));
                resultMap.put("dealed", MapUtils.getString(rpcResultMap, "dealed", "0"));
                resultMap.put("totalnumber", MapUtils.getString(rpcResultMap, "totalnumber", "0"));
            }
            resultMap.put("loginuserfullname", MapUtils.getString(params, "loginuserfullname", ""));
        }
        return resultMap;
    }

    public Map<String, Object> queryShopDetails(Map<String, Object> params) {
        ZLRpcResult rpcResult = apiEquipMonitorService.queryShopDetails(params);
        Map<String, Object> details = rpcResult.getMap();
        details.put("loginusername", MapUtils.getString(params, Contants.LOGIN_USER_FULL_NAME));
        return details;
    }

    public Page<?> queryHistoryFaultDetect(Map<String, Object> params) {
        ZLRpcResult rpcResult = apiEquipMonitorService.queryShopAllReports(params);
        if (rpcResult.success()){
            return (Page<?>)rpcResult.getData();
        }
        return null;
    }

    public void updateShopRepairStatus(Map<String, Object> params) {
        apiEquipMonitorService.updateShopRepairStatus(params);
    }
}
