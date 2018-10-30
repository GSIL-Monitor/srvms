package com.wgb.controller.device;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.exception.ServiceException;
import com.wgb.service.device.DeviceBugService;
import com.wgb.service.dubbo.bugms.admin.ApiDeviceBugService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.CommonUtil;
import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wgb on 2017/1/23.
 */
@Controller
@RequestMapping("/device/bug")
public class DeviceBugController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(DeviceBugController.class);

    @Autowired
    private DeviceBugService deviceBugService;

    @RequestMapping("/queryCollectDeviceInfo")
    @ResponseBody
    public ZLResult queryCollectDeviceInfo(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String ,Object> resultMap =  deviceBugService.queryCollectDeviceInfo(params);
            result.setData(resultMap);
        }catch (BusinessException ex){
            LOGGER.error("查询硬件检测汇总信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询硬件检测汇总信息系统异常!",ex);
        }
        return result;
    }


    @RequestMapping("/getDeviceDataCount")
    @ResponseBody
    public ZLResult getDeviceDataCount(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String ,Object> resultMap =  deviceBugService.getDeviceDataCount(params);
            result.setData(result);
        }catch (BusinessException ex){
            LOGGER.error("查询在线设备和故障设备总计业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询在线设备和故障设备总计系统异常!",ex);
        }
        return result;
    }

    /**
     * 查询在线设备
     * @param request
     * @return
     */
    @RequestMapping("/getOnlineDeviceAnalyzeData")
    @ResponseBody
    public ZLResult getOnlineDeviceAnalyzeData(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            List<Map<String, Object>> resultMap =  deviceBugService.getOnlineDeviceAnalyzeData(params);
            result.setData(result);
        }catch (BusinessException ex){
            LOGGER.error("查询在线设备业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询在线设备系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("/getHardwareBugCountData")
    @ResponseBody
    public ZLResult getHardwareBugCountData(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            List<Map<String, Object>> resultMap =  deviceBugService.getHardwareBugCountData(params);
            result.setData(result);
        }catch (BusinessException ex){
            LOGGER.error("查询硬件故障业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询硬件故障系统异常!",ex);
        }
        return result;
    }




    @RequestMapping("/report")
    public String report(HttpServletRequest request) {
        return "bug/device_bug_report";
    }

//    @RequestMapping("/getDeviceBugInfo")
//    @ResponseBody
//    public Map<String, Object> getDeviceBugInfo(HttpServletRequest request) {
//        Map<String, Object> params = getParams();
//
//        List<Map<String, Object>> shopList = srvShopService.getSrvShopList(params);
//        if (CollectionUtils.isNotEmpty(shopList)) {
//            List<String> shopcodeList = CommonUtil.getListStringFromListMap(shopList, "shopcode");
//            params.put("shopcodelist", shopcodeList);
//            ZLRpcResult result = apiDeviceBugService.getDeviceBugInfo(params);
//            return result.getMap();
//        }
//
//        return null;
//    }
}
