package com.wgb.controller.servicebill;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.service.FileUploadService;
import com.wgb.service.address.ServiceAddressService;
import com.wgb.service.dubbo.servicebill.ApitServiceBillService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.servicebill.ServiceBillService;
import io.netty.handler.codec.compression.ZlibCodecFactory;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * 维修工单
 *
 * @author fxs
 * @create 2018-07-09 10:22
 **/
@Controller
@RequestMapping("serviceBill")
public class ServiceBillController extends BaseController{

    private static final Logger LOGGER = LoggerFactory.getLogger(ServiceBillController.class);

    @Autowired
    private ServiceBillService billService;

    @RequestMapping("queryServiceBillPage")
    @ResponseBody
    public ZLResult queryServiceBillPage(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        try {
            Page<?> pageInfo = billService.qeuryServiceBillPage(getParams());
            result.setData(pageInfo);
        } catch (BusinessException ex){
            LOGGER.error("查询维修单据信息业务异常!" ,ex);
        }catch (Exception ex){
            LOGGER.error("查询维修单据信息系统异常!" ,ex);
        }
        //查询数据
        return result;
    }

    @RequestMapping("saveServiceBill")
    @ResponseBody
    public ZLResult saveServiceBill(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            billService.saveServiceBill(getParams());
        } catch (BusinessException ex){
            LOGGER.error("保存维修单据信息业务异常!" ,ex);
        }catch (Exception e) {
            LOGGER.error("保存维修单据信息系统异常!" ,e);
        }
        return result;
    }

    @RequestMapping("findPaymentDetail")
    @ResponseBody
    public ZLResult findPaymentDetail(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String, Object> data = billService.findPaymentDetail(getParams());
            result.setData(data);
        } catch (BusinessException ex){
            LOGGER.error("查询维修单据支付信息业务异常!" ,ex);
        }catch (Exception e) {
            LOGGER.error("查询维修单据支付信息系统异常!" ,e);
        }
        return result;
    }

    @RequestMapping("saveServiceBillPaymentMethod")
    @ResponseBody
    public ZLResult saveServiceBillPaymentMethod(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            billService.saveServiceBillPaymentMethod(params);
        } catch (BusinessException ex){
            LOGGER.error("保存维修单据支付信息业务异常!" ,ex);
        }catch (Exception e) {
            LOGGER.error("保存维修单据支付信息系统异常!" ,e);
        }
        return result;
    }

    @RequestMapping("cancelService")
    @ResponseBody
    public ZLResult cancelService(){
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            billService.cancelService(params);
        } catch (BusinessException ex){
            LOGGER.error("取消返修业务异常!" ,ex);
        }catch (Exception e) {
            LOGGER.error("取消返修系统异常!" ,e);
        }
        return result;
    }

    @RequestMapping("confirmReceipt")
    @ResponseBody
    public ZLResult confirmReceipt(HttpServletRequest request)  {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            billService.confirmReceipt(params);
        } catch (BusinessException ex){
            LOGGER.error("确认收货业务异常!" ,ex);
        }catch (Exception e) {
            LOGGER.error("确认收货系统异常!" ,e);
        }
        return result;
    }


    @RequestMapping("queryServiceBillDetail")
    @ResponseBody
    public ZLResult queryServiceBillDetail(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String ,Object> detail = billService.queryServiceBillDetail(params);
            result.setData(detail);
        } catch (BusinessException ex){
            LOGGER.error("查询维修单据详情业务异常!" ,ex);
        }catch (Exception e) {
            LOGGER.error("查询维修单据详情系统异常!" ,e);
        }
        return result;
    }
}
