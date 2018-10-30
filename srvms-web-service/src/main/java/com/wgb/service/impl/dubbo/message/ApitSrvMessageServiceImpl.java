package com.wgb.service.impl.dubbo.message;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.SrvMessageService;
import com.wgb.service.dubbo.srvms.web.ApitSrvMessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-10-08 11:09
 **/
@Service
public class ApitSrvMessageServiceImpl implements ApitSrvMessageService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ApitSrvMessageServiceImpl.class);
    @Autowired
    private SrvMessageService srvMessageService;

    public ZLRpcResult queryMessageDetail(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String ,Object> message = srvMessageService.queryMessageDetail(params);
        result.setData(message);
        return result;
    }

    public ZLRpcResult manage(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Page<?> pageInfo = srvMessageService.queryMessagePage(params);
        result.setData(pageInfo);
        return result;
    }
}
