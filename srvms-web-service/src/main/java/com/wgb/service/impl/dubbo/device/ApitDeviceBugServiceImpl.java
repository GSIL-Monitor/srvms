package com.wgb.service.impl.dubbo.device;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.device.DeviceBugService;
import com.wgb.service.dubbo.srvms.web.ApitDeviceBugService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 14:23
 **/
@Service
public class ApitDeviceBugServiceImpl implements ApitDeviceBugService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitDeviceBugServiceImpl.class);

    @Autowired
    private DeviceBugService deviceBugService;

    public ZLRpcResult queryCollectDeviceInfo(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String ,Object> resultMap =  deviceBugService.queryCollectDeviceInfo(params);
        result.setData(resultMap);
        return result;
    }

    public ZLRpcResult getDeviceDataCount(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String ,Object> resultMap =  deviceBugService.getDeviceDataCount(params);
        result.setData(resultMap);
        return result;
    }

    public ZLRpcResult getOnlineDeviceAnalyzeData(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> resultMap =  deviceBugService.getOnlineDeviceAnalyzeData(params);
        result.setData(resultMap);
        return result;
    }

    public ZLRpcResult getHardwareBugCountData(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> resultMap =  deviceBugService.getHardwareBugCountData(params);
        result.setData(resultMap);
        return result;
    }
}
