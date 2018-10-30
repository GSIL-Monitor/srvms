package com.wgb.service.impl.hardware;

import com.wgb.service.hardware.HardwareDeviceService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-07-02 14:32
 **/
@Service
public class HardwareDeviceServiceImpl implements HardwareDeviceService{

    public List<Map<String, Object>> queryHardwareDeviceModelByType(Map<String, Object> params) {
        return null;
    }

    public List<Map<String, Object>> queryHardwareDeviceTypeAll(Map<String, Object> params) {
        List<Map<String, Object>> hardwareDeviceType = new ArrayList<>();
        HashMap<String, Object> advertisingMachine = new HashMap<>(); // 广告机器
        advertisingMachine.put("productcategory" ,"2");
        advertisingMachine.put("productcategoryname" ,"广告机");

        HashMap<String, Object> cashRegister = new HashMap<>(); // 收银机
        cashRegister.put("productcategory" ,"1");
        cashRegister.put("productcategoryname" ,"收银机");

        hardwareDeviceType.add(advertisingMachine);
        hardwareDeviceType.add(cashRegister);

        return hardwareDeviceType;
    }
}
