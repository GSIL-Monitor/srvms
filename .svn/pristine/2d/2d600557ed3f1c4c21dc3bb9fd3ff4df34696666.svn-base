package com.wgb.service.impl.dubbo;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.srvms.admin.ApiSrvPayService;
import com.wgb.service.srv.SrvPayService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class ApiSrvPayServiceImpl implements ApiSrvPayService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ApiSrvPayServiceImpl.class);

    @Autowired
    private SrvPayService srvPayService;

    public ZLRpcResult savePayInfoCallback(Map<String, Object> params) {
        ZLRpcResult rpcResult = new ZLRpcResult();
        try {
            LOGGER.info(params + "");
            srvPayService.updatePayInfo(params);
        } catch (ServiceException e) {
            LOGGER.error("回调保存订单支付信息失败!", e);
            rpcResult.setErrorCode(e.getCode());
        } catch (Exception e) {
            // 异常处理
            LOGGER.error("回调保存订单支付信息失败!", e);
            rpcResult.setErrorCode(ServiceException.SYS_ERROR);
        }
        return rpcResult;
    }
}
