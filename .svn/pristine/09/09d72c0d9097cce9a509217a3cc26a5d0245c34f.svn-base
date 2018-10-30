package com.wgb.service.impl.dubbo.workorder;

import com.wgb.bean.ZLResult;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitWorkOrderService;
import com.wgb.service.workorder.WorkOrderService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 17:14
 **/
@Service
public class ApitWorkOrderServiceImpl implements ApitWorkOrderService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitWorkOrderServiceImpl.class);
    @Autowired
    private WorkOrderService workOrderService;

    public ZLRpcResult queryWorkOrderPage(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        checkWorkOrderStatus(params);
        Page<?> pageInfo = workOrderService.queryWorkOrderPage(params);
        result.setData(pageInfo);
        return result;
    }

    private void checkWorkOrderStatus(Map<String ,Object> params){
        String workorderstatus = MapUtils.getString(params, "workorderstatus");
        if(StringUtils.isNotBlank(workorderstatus)){
            String[] split = workorderstatus.split(",");
            params.put("workorderstatus" , Arrays.asList(split));
        }else{
            params.remove("workorderstatus");
        }
    }

    public ZLRpcResult queryHardwareDeviceCategory(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> hardwareDeviceList = workOrderService.queryHardwareDeviceCategory(params);
        result.setData(hardwareDeviceList);
        return result;
    }

    public ZLRpcResult queryHardwareByProductCategory(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> hardwareDeviceList = workOrderService.queryHardwareByProductCategory(params);
        result.setData(hardwareDeviceList);
        return result;
    }

    public ZLRpcResult queryShopByShopCodeAndShopName(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String ,Object>> shopInfo = workOrderService.queryShopcodeListForSrvms(params);
        result.setData(shopInfo);
        return result;
    }

    public ZLRpcResult querBranchByShopCode(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String ,Object>> branchInfo = workOrderService.queryBranchListByServer(params);
        result.setData(branchInfo);
        return result;
    }

    public ZLRpcResult queryPartsByCategoryAndModel(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String ,Object>> partsInfo = workOrderService.queryPartsByCategoryAndModel(params);
        result.setData(partsInfo);
        return result;
    }

    public ZLRpcResult saveWorkOrder(Map<String ,Object> params ){
        ZLRpcResult result = new ZLRpcResult();
        workOrderService.saveWorkOrder(params);
        return result;
    }


    public ZLRpcResult queryWorkOrderDetail(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Map<String ,Object> workOrderInfo = workOrderService.queryWorkOrderDetail(params);
        result.setData(workOrderInfo);
        return result;
    }

    public ZLRpcResult deleteWorkOrderByCode(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        workOrderService.deleteWorkOrderByCode(params);
        return result;
    }

    public ZLRpcResult findWorkOrderByWaitRepair(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Page<?> pageInfo = workOrderService.findWorkOrderByWaitRepair(params);
        result.setData(pageInfo);
        return result;
    }

    public ZLRpcResult findWorkOrderByWorkOrderCode(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Map<String ,Object> data = workOrderService.findWorkOrderByWorkOrderCode(params);
        result.setData(data);
        return result;
    }

    public ZLRpcResult finishService(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        String message = workOrderService.updateWorkOrderStatus(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }

    public ZLRpcResult findWorkOrderPrice(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Map<String ,Object> dataMap = workOrderService.findWorkOrderPrice(params);
        result.setData(dataMap);
        return result;
    }
}
