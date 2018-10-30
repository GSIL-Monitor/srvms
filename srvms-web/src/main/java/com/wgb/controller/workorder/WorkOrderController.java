package com.wgb.controller.workorder;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.service.FileUploadService;
import com.wgb.service.dubbo.urms.admin.ApiBranchService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.dubbo.urms.web.ApitComponentService;
import com.wgb.service.dubbo.urms.web.ApitHardwareService;
import com.wgb.service.dubbo.workorder.web.ApitWorkOrderService;
import com.wgb.service.hardware.HardwareDeviceService;
import com.wgb.service.workorder.WorkOrderService;
import io.netty.handler.codec.compression.ZlibCodecFactory;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.print.Pageable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 工单
 *
 * @author fxs
 * @create 2018-06-28 15:12
 **/
@Controller
@RequestMapping("workorder")
public class WorkOrderController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(WorkOrderController.class);
    @Autowired
    private WorkOrderService workOrderService;

    @RequestMapping("queryWorkOrderPage")
    @ResponseBody
    public ZLResult queryWorkOrderPage(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        checkWorkOrderStatus(params);
        try {
            Page<?> pageInfo = workOrderService.queryWorkOrderPage(params);
            result.setData(pageInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询工单列表页业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询工单列表页系统异常!",ex);
        }
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

    @RequestMapping("queryHardwareDeviceCategory")
    @ResponseBody
    public ZLResult queryHardwareDeviceCategory(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            List<Map<String, Object>> hardwareDeviceList = workOrderService.queryHardwareDeviceCategory(params);
            result.setData(hardwareDeviceList);
        }catch (BusinessException ex){
            LOGGER.error("查询硬件设备类型业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询硬件设备类型系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("queryHardwareByProductCategory")
    @ResponseBody
    public ZLResult queryHardwareByProductCategory(){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            List<Map<String, Object>> hardwareDeviceList = workOrderService.queryHardwareByProductCategory(params);
            result.setData(hardwareDeviceList);
        }catch (BusinessException ex){
            LOGGER.error("查询硬件设备型号业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询硬件设备型号系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("queryShopByShopCodeAndShopName")
    @ResponseBody
    public ZLResult queryShopByShopCodeAndShopName(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            List<Map<String ,Object>> shopInfo = workOrderService.queryShopcodeListForSrvms(params);
            result.setData(shopInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询商户信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询商户信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("querBranchByShopCode")
    @ResponseBody
    public ZLResult querBranchByShopCode(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            List<Map<String ,Object>> branchInfo = workOrderService.queryBranchListByServer(params);
            result.setData(branchInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询门店信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询门店信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("queryPartsByCategoryAndModel")
    @ResponseBody
    public ZLResult queryPartsByCategoryAndModel(){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            List<Map<String ,Object>> branchInfo = workOrderService.queryPartsByCategoryAndModel(params);
            result.setData(branchInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询硬件产品配件信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询硬件产品配件信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("saveWorkOrder")
    @ResponseBody
    public ZLResult saveWorkOrder(HttpServletRequest request ){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            workOrderService.saveWorkOrder(params);
        }catch (BusinessException ex){
            LOGGER.error("保存工单信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("保存工单信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("queryWorkOrderDetail")
    @ResponseBody
    public ZLResult queryWorkOrderDetail(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            Map<String ,Object> workOrderInfo = workOrderService.queryWorkOrderDetail(params);
            result.setData(workOrderInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询工单信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询工单信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("deleteWorkOrderByCode")
    @ResponseBody
    public ZLResult deleteWorkOrderByCode(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
           workOrderService.deleteWorkOrderByCode(params);
        }catch (BusinessException ex){
            LOGGER.error("删除信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("删除工单信息系统异常!",ex);
        }
        return result;
    }

    /**
     * 维修单据查询
     * @param request
     * @return
     */
    @RequestMapping("findWorkOrderByWaitRepair")
    @ResponseBody
    public ZLResult findWorkOrderByWaitRepair(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            Page<?> pageInfo = workOrderService.findWorkOrderByWaitRepair(params);
            result.setData(pageInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询服务商下工单列表信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询服务商下工单列表信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("findWorkOrderByWorkOrderCode")
    @ResponseBody
    public ZLResult findWorkOrderByWorkOrderCode(){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            Map<String ,Object> data = workOrderService.findWorkOrderByWorkOrderCode(params);
            result.setData(data);
        }catch (BusinessException ex){
            LOGGER.error("维修单据查询工单详情信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("维修单据查询工单详情信息系统异常!",ex);
        }
        return result;
    }




//    @RequestMapping("toServerHandle")
//    public String toServerHandle(HttpServletRequest request){
//        Map<String, Object> params = getParams();
//        String type = MapUtils.getString(params, "type");
//        request.setAttribute("workordercode" ,MapUtils.getString(params ,"workordercode"));
//        if ("1".equalsIgnoreCase(type)){ // 点击的立即处理
//            // 修改状态
//            params.put("workorderstatus" ,"1");
//            apitWorkOrderService.serverHandle(params);
//        }
//        return "workorder/work_order_handle";
//    }
//
//    @RequestMapping("saveServerHandleInfo")
//    @ResponseBody
//    public ZLResult saveServerHandleInfo(HttpServletRequest request){
//        ZLResult result = ZLResult.Success();
//        try {
//            // 保存服务商处理信息
//            Map<String, Object> params = getParams();
//            // 判断服务商点击的处理状态 0 自行处理 1上报反馈
//            String resultcode = MapUtils.getString(params, "resultcode");
//            switch (resultcode){
//                case "0" :
//                    params.put("workorderstatus" ,"8"); // 自行处理了，结束单据
//                    break;
//                case "1" :
//                    params.put("workorderstatus" ,"2"); // 反馈上级
//                    break;
//            }
//            ZLRpcResult rpcResult = apitWorkOrderService.serverHandle(params);
//            if(null != rpcResult && rpcResult.success()){
//                result.setData("保存成功!");
//            }else{
//                result.setData("保存失败!请联系系统管理员!");
//            }
//        } catch (Exception ex){
//            result.setData("保存失败!请联系系统管理员!");
//            LOGGER.error("保存服务商处理进度失败!" ,ex);
//        }
//        return result;
//    }
//
//    @RequestMapping("finishService")
//    @ResponseBody
//    public String finishService(HttpServletRequest request){
//        Map<String, Object> params = getParams();
//        ZLRpcResult result = apitWorkOrderService.updateWorkOrderStatus(params);
//        if (result.success()){
//            return "";
//        }
//        return result.getData().toString();
//    }
//

//

//
//    @RequestMapping("findWorkOrderPrice")
//    public String findWorkOrderPrice(HttpServletRequest request){
//        ZLRpcResult result = apitWorkOrderService.findWorkOrderPrice(getParams());
//        if(null != result && result.success()){
//            List<Map<String ,Object>> datas = (List<Map<String ,Object>>)result.getData();
//            request.setAttribute("workOrderPrices" ,datas);
//            BigDecimal totalPrice = new BigDecimal(0);
//            BigDecimal totalNums = new BigDecimal(0);
//            if (null != datas && datas.size() > 0){
//                for (Map<String ,Object> data : datas){
//                    BigDecimal subTotalPrice = new BigDecimal(data.get("totalprice").toString());
//                    totalPrice = totalPrice.add(subTotalPrice);
//                    BigDecimal nums = new BigDecimal(data.get("nums").toString());
//                    totalNums = totalNums.add(nums);
//                }
//                request.setAttribute("totalPrice" ,totalPrice);
//                request.setAttribute("totalNums" ,totalNums);
//            }
//        }
//        return "workorder/work_order_price";
//    }
}
