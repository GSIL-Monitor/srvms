package com.wgb.service.impl.workorder;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.servicebill.ApitServiceBillService;
import com.wgb.service.dubbo.urms.admin.ApiBranchService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.dubbo.urms.web.ApitHardwareService;
import com.wgb.service.dubbo.urms.web.ApitShopService;
import com.wgb.service.dubbo.workorder.web.ApitWorkOrderService;
import com.wgb.service.hardware.HardwareDeviceService;
import com.wgb.service.workorder.WorkOrderService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-07-02 14:47
 **/
@Service
public class WorkOrderServiceImpl implements WorkOrderService {

    private static final Logger LOGGER = LoggerFactory.getLogger(WorkOrderServiceImpl.class);

    @Autowired
    private ApitWorkOrderService apitWorkOrderService;

    @Autowired
    private HardwareDeviceService hardwareDeviceService;

    @Autowired
    private ApitHardwareService apitHardwareServicel;

    @Autowired
    private ApiShopService shopService;

    @Autowired
    private ApiBranchService branchService;

    @Autowired
    private ApitShopService apitShopService;

    @Autowired
    private ApitServiceBillService apitServiceBillService;


    public Page<?> queryWorkOrderPage(Map<String, Object> params) {
        ZLRpcResult result = apitWorkOrderService.findWorkOrder(params);
        if(result.success()){
           return (Page<?>)result.getData();
        }
        return null;
    }

    public List<Map<String, Object>> queryHardwareDeviceCategory(Map<String, Object> params) {
        return hardwareDeviceService.queryHardwareDeviceTypeAll(params);
    }

    public List<Map<String, Object>> queryHardwareByProductCategory(Map<String, Object> params) {
        ZLRpcResult rpcResult = apitHardwareServicel.queryHardwareByProductCategory(params);
        if (rpcResult.success()){
            return (List<Map<String, Object>>)rpcResult.getData();
        }
        return null;
    }

    @Override
    public List<Map<String, Object>> queryShopcodeListForSrvms(Map<String, Object> params) {
        ZLRpcResult industryList = apitShopService.getShopListAllRechargeForSalver(params);
        if (null != industryList && industryList.success()){
            return industryList.getList();
        }
        throw new ServiceException(industryList.getErrorMsg());
    }

    public List<Map<String, Object>> queryBranchListByServer(Map<String, Object> params) {
        ZLRpcResult result = branchService.queryBranchListByServer(params);
        if (null != result && result.success()){
            return  (List<Map<String ,Object>>)result.getData();
        }
        return null;
    }

    @Override
    public List<Map<String, Object>> queryPartsByCategoryAndModel(Map<String, Object> params) {
        ZLRpcResult result = apitHardwareServicel.queryPartsByCategoryAndModel(params);
        if (null !=  result && result.success()){
            return (List<Map<String ,Object>>)result.getData();
        }
        return null;
    }

    @Override
    public void saveWorkOrder(Map<String, Object> params) {
        params.put("feedbackplatform" ,1);// 反馈平台
        params.put("createplatform" ,1);// 创建平台
        params.put("workorderstatus" ,"2");
        // 保存工单信息
        ZLRpcResult rpcResult = apitWorkOrderService.saveWorkOrder(params);
        if (!rpcResult.success()){
            LOGGER.error("调用dubbo系统异常！", rpcResult.getErrorMsg());
            throw new BusinessException(BusinessException.getExceptionBean("biz.system.err"));
        }
    }

    /**
     * 获取工单详情
     * @param params
     * @return
     */
    public  Map<String, Object> queryWorkOrderDetail(Map<String ,Object> params){
        Map<String, Object> workOrderDetails = null;
        ZLRpcResult result = apitWorkOrderService.findWorkOrderDetail(params);
        List<String> imageUrls = new ArrayList<>();
        if (null != result || result.success()){
            workOrderDetails  = (Map<String, Object>)result.getData();
            if (MapUtils.isNotEmpty(workOrderDetails)){
                setImgUrl(workOrderDetails);
                // 计算维修金额
                calculateAmount(workOrderDetails);
            }
        }
        return workOrderDetails;
    }

    @Override
    public void deleteWorkOrderByCode(Map<String, Object> params) {
        ZLRpcResult result = apitWorkOrderService.deleteWorkOrderByCode(params);
    }

    public Page<?> findWorkOrderByWaitRepair(Map<String, Object> params){
        ZLRpcResult result = apitWorkOrderService.findWorkOrderByWaitRepair(params);
        if( null != result && result.success()){
          return (Page<?>)result.getData();
        }
        return null ;
    }

    public Map<String, Object> findWorkOrderByWorkOrderCode(Map<String, Object> params) {
        ZLRpcResult result = apitWorkOrderService.findWorkOrderByWorkOrderCode(params);
        if(null != result && result.success()){
            Map<String ,Object> data = (Map<String ,Object>)result.getData();
            if (MapUtils.isNotEmpty(data)){
                ZLRpcResult model = apitHardwareServicel.queryHardwareByProductCategory(data);
                if (null != model && model.success()){
                    data.put("productmodels" ,model.getData());
                }
            }
            return data;
        }
        return null;
    }

    @Override
    public String updateWorkOrderStatus(Map<String, Object> params) {
        boolean status = checkServiceBillStatus(params);
        if (status){
            ZLRpcResult result = apitWorkOrderService.updateWorkOrderStatus(params);
            if (result.success()){
                return "";
            }
            return result.getData().toString();
        }
        return "维修工单未完成维修!";
    }

    private boolean checkServiceBillStatus(Map<String, Object> params) {
        Map<String ,Object> queryServiceBill = new HashMap<>();
        queryServiceBill.put("servercode" ,MapUtils.getString(params ,"servercode" ,""));
        queryServiceBill.put("workordercode" ,MapUtils.getString(params ,"workordercode" ,""));
        queryServiceBill.put("servicebillstatus" ,"7");
        // 根据工单编号查询当前工单是否完成维修
        ZLRpcResult rpcResult = apitServiceBillService.queryServiceBillByStatus(queryServiceBill);
        if (null !=  rpcResult && rpcResult.success()){
            List data = rpcResult.getList();
            if (null == data || data.size() == 0){
                return false;
            }
            return true;
        }
        LOGGER.error("调用dubbo系统异常！", rpcResult.getErrorMsg());
        throw new BusinessException(BusinessException.getExceptionBean("biz.system.err"));
    }

    @Override
    public Map<String, Object> findWorkOrderPrice(Map<String, Object> params) {
        ZLRpcResult rpcResult = apitWorkOrderService.findWorkOrderPrice(params);
        Map<String ,Object> result = new HashMap<>();
        if(null != rpcResult && rpcResult.success()){
            List<Map<String ,Object>> datas = (List<Map<String ,Object>>)rpcResult.getData();
            result.put("workOrderPrices" ,datas);
            BigDecimal totalPrice = new BigDecimal(0);
            BigDecimal totalNums = new BigDecimal(0);
            if (null != datas && datas.size() > 0){
                for (Map<String ,Object> data : datas){
                    BigDecimal subTotalPrice = new BigDecimal(data.get("totalprice").toString());
                    totalPrice = totalPrice.add(subTotalPrice);
                    BigDecimal nums = new BigDecimal(data.get("nums").toString());
                    totalNums = totalNums.add(nums);
                }
                result.put("totalPrice" ,totalPrice);
                result.put("totalNums" ,totalNums);
            }
        }
        return result;
    }

    /**
     * 设置 imgurl
     * @param workOrderDetails
     */
    private void setImgUrl(Map<String ,Object> workOrderDetails){
        if( null != workOrderDetails && workOrderDetails.size() > 0){
            String imageurl = MapUtils.getString(workOrderDetails, "imageurl");
            List<String> imageUrls = new ArrayList<>();
            if (StringUtils.isNotBlank(imageurl)){
                for (String imgUrl : imageurl.split(",")){
                    imageUrls.add(imgUrl);
                }
            }
            workOrderDetails.put("imageUrls",imageUrls);
        }
    }

    /**
     * 计算维修金额
     * @param workOrderDetails
     */
    private void calculateAmount(Map<String ,Object> workOrderDetails){
        // 计算维修总金额
        List<Map<String, Object>> serviceWorkOrderPrice = ( List<Map<String, Object>>)workOrderDetails.get("serviceWorkOrderPrice");
        if(null != serviceWorkOrderPrice && serviceWorkOrderPrice.size() > 0){
            BigDecimal totalNums = new BigDecimal(0);
            BigDecimal totalPrice = new BigDecimal(0);
            for (Map<String ,Object> map : serviceWorkOrderPrice){
                Object subprice = map.get("totalprice");
                Object nums = map.get("nums");
                totalPrice = totalPrice.add(new BigDecimal(subprice.toString()));
                totalNums = totalNums.add(new BigDecimal(nums.toString()));
            }
            workOrderDetails.put("totalNums" ,totalNums);
            workOrderDetails.put("totalPrice" ,totalPrice);
        }
    }
}
