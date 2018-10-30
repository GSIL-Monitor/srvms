package com.wgb.service.impl.dubbo.equipmonitor;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitEquipMonitorService;
import com.wgb.service.equipmonitor.EquipMonitorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 15:10
 **/
@Service
public class ApitEquipMonitorServiceImpl implements ApitEquipMonitorService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ApitEquipMonitorServiceImpl.class);
    @Autowired
    private EquipMonitorService equipMonitorService;

    public ZLRpcResult queryFaultDetect(Map<String,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object>  analysis = equipMonitorService.queryFaultDetect(params);
        result.setData(analysis);
        return result;
    }

    public ZLRpcResult queryShopDetails(Map<String,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object>  analysis = equipMonitorService.queryShopDetails(params);
        result.setData(analysis);
        return result;
    }
    
    public ZLRpcResult queryHistoryFaultDetect(Map<String,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Page<?> pageInfo = equipMonitorService.queryHistoryFaultDetect(params);
        result.setData(pageInfo);
        return result;
    }

    public ZLRpcResult updateShopRepairStatus(Map<String,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        equipMonitorService.updateShopRepairStatus(params);
        return result;
    }
}
