package com.wgb.service.impl.dubbo.servicebill;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitServiceBillService;
import com.wgb.service.servicebill.ServiceBillService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-30 15:14
 **/
@Service
public class ApitServiceBillServiceImpl implements ApitServiceBillService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitServiceBillServiceImpl.class);

    @Autowired
    private ServiceBillService billService;

    public ZLRpcResult queryServiceBillPage(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Page<?> pageInfo = billService.qeuryServiceBillPage(params);
        result.setData(pageInfo);
        //查询数据
        return result;
    }

    public ZLRpcResult saveServiceBill(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        billService.saveServiceBill(params);
        return result;
    }

    public ZLRpcResult findPaymentDetail(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object> data = billService.findPaymentDetail(params);
        result.setData(data);
        return result;
    }

    public ZLRpcResult saveServiceBillPaymentMethod(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        billService.saveServiceBillPaymentMethod(params);
        return result;
    }

    public ZLRpcResult cancelService(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        billService.cancelService(params);
        return result;
    }

    public ZLRpcResult confirmReceipt(Map<String ,Object> params)  {
        ZLRpcResult result = new ZLRpcResult();
        billService.confirmReceipt(params);
        return result;
    }

    public ZLRpcResult queryServiceBillDetail(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Map<String ,Object> detail = billService.queryServiceBillDetail(params);
        result.setData(detail);
        return result;
    }
}
