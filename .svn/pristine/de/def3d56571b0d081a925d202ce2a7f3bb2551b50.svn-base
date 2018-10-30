package com.wgb.service.impl.device;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.exception.ServiceException;
import com.wgb.service.device.DeviceBugService;
import com.wgb.service.dubbo.bugms.admin.ApiDeviceBugService;
import com.wgb.service.srv.SrvShopService;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 13:59
 **/
@Service
public class DeviceBugServiceImpl implements DeviceBugService {

    @Autowired
    private ApiDeviceBugService apiDeviceBugService;

    @Autowired
    private SrvShopService srvShopService;

    public Map<String, Object> queryCollectDeviceInfo(Map<String, Object> params) {
        Map<String ,Object> reusltMap = new HashMap<>();
        List<Map<String, Object>> shopList = srvShopService.getSrvShopList(params);
        if (CollectionUtils.isNotEmpty(shopList)) {
            params.put("shoplist", shopList);
            //设备统计数据
            ZLRpcResult deviceDataCount = apiDeviceBugService.getShopDeviceDataCount(params);
            //在线设备分析数据
            ZLRpcResult onlineDeviceAnalyzeData = apiDeviceBugService.getShopOnlineDeviceAnalyzeData(params);
            //硬件故障统计数据
            ZLRpcResult hardwareBugCountData = apiDeviceBugService.getShopHardwareBugCountData(params);
            reusltMap.put("deviceDataCount", deviceDataCount.getMap());
            reusltMap.put("onlineDeviceAnalyzeData", onlineDeviceAnalyzeData.getList());
            reusltMap.put("hardwareBugCountData", hardwareBugCountData.getList());
        }
        return reusltMap;
    }

    public Map<String, Object> getDeviceDataCount(Map<String, Object> params) {
        List<Map<String, Object>> shopList = srvShopService.getSrvShopList(params);
        if (CollectionUtils.isNotEmpty(shopList)) {
            params.put("shoplist", shopList);
            ZLRpcResult count = apiDeviceBugService.getShopDeviceDataCount(params);
            return count.getMap();
        }
        return null;
    }

    public List<Map<String, Object>> getOnlineDeviceAnalyzeData(Map<String, Object> params) {
        List<Map<String, Object>> shopList = srvShopService.getSrvShopList(params);
        if (CollectionUtils.isNotEmpty(shopList)) {
            params.put("shoplist", shopList);
            ZLRpcResult data = apiDeviceBugService.getShopOnlineDeviceAnalyzeData(params);
            return data.getList();
        }
        return null;
    }

    public List<Map<String, Object>> getHardwareBugCountData(Map<String, Object> params) {
        List<Map<String, Object>> shopList = srvShopService.getSrvShopList(params);
        if (CollectionUtils.isNotEmpty(shopList)) {
            params.put("shoplist", shopList);
            ZLRpcResult count = apiDeviceBugService.getShopHardwareBugCountData(params);
            return count.getList();
        }
        return null;
    }
}
