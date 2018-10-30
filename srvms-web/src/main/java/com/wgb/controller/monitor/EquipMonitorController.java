package com.wgb.controller.monitor;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.bugms.admin.ApiEquipMonitorService;
import com.wgb.service.equipmonitor.EquipMonitorService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.rmi.runtime.Log;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wgb on 2017/1/23.
 */
@Controller
@RequestMapping("/equipmonitor")
public class EquipMonitorController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(EquipMonitorController.class);

    @Autowired
    private EquipMonitorService equipMonitorService;

    @RequestMapping("/queryFaultDetect")
    @ResponseBody
    public ZLResult queryFaultDetect(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String, Object>  analysis = equipMonitorService.queryFaultDetect(params);
            result.setData(analysis);
        }catch (BusinessException ex){
            LOGGER.error("查询故障检测列表信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询故障检测列表信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("/queryShopDetails")
    @ResponseBody
    public ZLResult queryShopDetails(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String, Object>  analysis = equipMonitorService.queryShopDetails(params);
            result.setData(analysis);
        }catch (BusinessException ex){
            LOGGER.error("查询故障检测商户详情信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询故障检测商户详情信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("/queryHistoryFaultDetect")
    @ResponseBody
    public ZLResult queryHistoryFaultDetect(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Page<?> pageInfo = equipMonitorService.queryHistoryFaultDetect(params);
            result.setData(pageInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询设备历史上报故障信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询设备历史上报故障信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("/updateShopRepairStatus")
    @ResponseBody
    public ZLResult updateShopRepairStatus(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            equipMonitorService.updateShopRepairStatus(params);
        }catch (BusinessException ex){
            LOGGER.error("查询设备历史上报故障信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询设备历史上报故障信息系统异常!",ex);
        }
        return result;
    }
}
