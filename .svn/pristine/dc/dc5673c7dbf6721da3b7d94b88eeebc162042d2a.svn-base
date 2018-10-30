package com.wgb.controller.hardware;

import com.wgb.controller.BaseController;
import com.wgb.service.hardware.HardwareDeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;

/**
 * 硬件设备
 *
 * @author fxs
 * @create 2018-07-02 14:25
 **/
@Controller
@RequestMapping("hardwareDevice")
public class HardwareDeviceController extends BaseController{

    @Autowired
    private HardwareDeviceService hardwareDeviceService;

    // 根据产品的类型查询所有硬件设备的型号
    @RequestMapping("queryHardwareDeviceModelByType")

    private List<Map<String ,Object>> queryHardwareDeviceModelByType(){
        List<Map<String ,Object>> hardwareDevices =  hardwareDeviceService.queryHardwareDeviceModelByType(getParams());
        return null;
    }


}
