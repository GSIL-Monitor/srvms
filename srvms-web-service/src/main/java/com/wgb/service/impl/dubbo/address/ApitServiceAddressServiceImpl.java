package com.wgb.service.impl.dubbo.address;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.address.ServiceAddressService;
import com.wgb.service.dubbo.srvms.web.ApitServiceAddressService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-10-09 9:23
 **/
@Service
public class ApitServiceAddressServiceImpl implements ApitServiceAddressService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitServiceAddressServiceImpl.class);

    @Autowired
    private ServiceAddressService serviceAddressService;

    public ZLRpcResult queryServiceAddress(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object> resultMap = serviceAddressService.queryServiceAddress(params);
        result.setData(resultMap);
        return result;
    }
}
