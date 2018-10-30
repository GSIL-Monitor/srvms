package com.wgb.service.impl.dubbo.shop;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitSrvAssociationShopService;
import com.wgb.service.srv.SrvAssociationShopService;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-10-08 9:42
 **/
@Service
public class ApitSrvAssociationShopServiceImpl implements ApitSrvAssociationShopService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitSrvAssociationShopServiceImpl.class);

    @Autowired
    private SrvAssociationShopService srvAssociationShopService;

    /*
     *获取关联商户数据
     */
    public ZLRpcResult getShopInfo(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object> data =  srvAssociationShopService.getShopInfo(params);
        result.setData(data);
        return result;
    }

    public ZLRpcResult sendYzm(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String message = srvAssociationShopService.sendYzm(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }

    /*
     *关联商户
     */
    public ZLRpcResult addAssociationInfo(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String message = srvAssociationShopService.addAssociationInfo(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }
}
