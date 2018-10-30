package com.wgb.service.impl.dubbo.information;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitSrvInformationService;
import com.wgb.service.srv.PubSrvService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 10:44
 **/
@Service
public class ApitSrvInformationServiceImpl implements ApitSrvInformationService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ApitSrvInformationServiceImpl.class);

    @Autowired
    private PubSrvService pubSrvService;

    public ZLRpcResult detail(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object> srvDetail = pubSrvService.querySrvDetails(params);
        result.setData(srvDetail);
        return result;
    }
}
