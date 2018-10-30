package com.wgb.service.impl.servicebill;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.service.address.ServiceAddressService;
import com.wgb.service.dubbo.servicebill.ApitServiceBillService;
import com.wgb.service.servicebill.ServiceBillService;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-30 13:55
 **/
@Service
public class ServiceBillServiceImpl implements ServiceBillService{

    @Autowired
    private ApitServiceBillService serviceBillService;

    @Autowired
    private ServiceAddressService serviceAddressService;

    public Page<?> qeuryServiceBillPage(Map<String, Object> params) {
        ZLRpcResult result = serviceBillService.findServiceBillByPage(params);
        if (null != result && result.success()){
           return (Page<?>)result.getData();
        }
        return null;
    }

    public void saveServiceBill(Map<String, Object> params) {
        ZLRpcResult rpcResult = serviceBillService.saveServiceBill(params);
        if (rpcResult.success()){
            serviceAddressService.updateServiceAddress(params);
            return;
        }
        throw new BusinessException(BusinessException.getExceptionBean("biz.dubbo.system"));
    }

    public Map<String ,Object> findPaymentDetail(Map<String, Object> params) {
        Map<String ,Object> result = new HashMap<>();
        // 查询鉴定信息
        ZLRpcResult priceResult = serviceBillService.findServicePartDetail(params);
        if (null != priceResult && priceResult.success()){
            List<Map<String ,Object>> priceList = (List<Map<String ,Object>>)priceResult.getData();
            result.put("priceResult" ,priceList);
            BigDecimal totalnums = new BigDecimal(0);
            BigDecimal totalPrice  = new BigDecimal(0);
            for (Map<String ,Object> priceMap : priceList){
                totalnums = totalnums.add(new BigDecimal(MapUtils.getString(priceMap ,"nums")));
                totalPrice = totalPrice.add(new BigDecimal(MapUtils.getString(priceMap ,"totalprice")));
            }
            result.put("totalnums" , totalnums);
            result.put("totalamount" , totalPrice);
        }
        ZLRpcResult rpcResult = serviceBillService.findPaymentDetail(params);
        if (null != rpcResult && rpcResult.success()){
            result.put("paymentDetail" , rpcResult.getData());
        }
        return result;
    }

    public void saveServiceBillPaymentMethod(Map<String, Object> params) {
          serviceBillService.updateServiceBillOrder(params);
    }

    public void cancelService(Map<String, Object> params) {
        params.put("servicebillstatus" ,"5");
        ZLRpcResult result = serviceBillService.updateServiceBillStatus(params);
    }

    @Override
    public void confirmReceipt(Map<String, Object> params) {
        Map<String ,Object> queryParams = new HashMap<>();
        queryParams.put("servicebillcode" ,MapUtils.getString(params ,"servicebillcode"));
        queryParams.put("servicebillstatus" ,"6");
        ZLRpcResult rpcResult = serviceBillService.queryServiceBillByStatus(queryParams);
        if (null != rpcResult && rpcResult.success()){
            if (null != rpcResult.getData() && ((List<Map<String ,Object>>)(rpcResult.getData())).size() > 0){
                params.put("consigneeplatform" ,"1");
                ZLRpcResult rpcResult2 = serviceBillService.updateCustomerConfirmReceipt(params);
            }
        }
    }

    public Map<String, Object> queryServiceBillDetail(Map<String, Object> params) {
        Map<String ,Object> resultMap = new HashMap<>();
        ZLRpcResult result = serviceBillService.findServiceBillDetailByCode(params);
        if (null != result && result.success()){
            Map<String ,Object> serviceBillDetail = ( Map<String ,Object>)result.getData();
            if (null != serviceBillDetail && serviceBillDetail.size() > 0 ){
                List<Map<String, Object>> priceParts = ( List<Map<String, Object>>)serviceBillDetail.get("priceParts");
                BigDecimal totalpric = new BigDecimal(0);
                BigDecimal totalnums = new BigDecimal(0);
                for (Map<String, Object> priceMap :priceParts){
                    totalpric = totalpric.add(new BigDecimal(MapUtils.getString( priceMap ,"totalprice")));
                    totalnums = totalnums.add(new BigDecimal(MapUtils.getString( priceMap ,"nums")));
                }
                resultMap.put("totalNums" ,totalnums);
                resultMap.put("totalPrice" ,totalpric);
            }
            resultMap.put("serviceBillDetail" ,serviceBillDetail);
        }else{
            resultMap.put("serviceBillDetail" ,null);
        }
        return resultMap;
    }
}
