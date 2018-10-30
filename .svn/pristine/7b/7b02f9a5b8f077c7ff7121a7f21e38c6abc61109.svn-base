package com.wgb.service.impl.dubbo;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.service.dubbo.srvms.web.ApitSrvShopService;
import com.wgb.service.srv.PubSrvService;
import com.wgb.service.srv.SrvShopService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by wgy on 2018/9/11.
 */
@Service
public class ApitSrvShopServiceImpl implements ApitSrvShopService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitSrvShopServiceImpl.class);

    @Autowired
    private SrvShopService srvShopService;

    @Autowired
    private PubSrvService pubSrvService;


    public ZLRpcResult insertServerShop(Map<String, Object> params) {
        ZLRpcResult rpcResult = new ZLRpcResult();
        srvShopService.insertServerShop(params);
        return rpcResult;
    }

    public ZLRpcResult getServerCodeByCode(Map<String, Object> params) {
        ZLRpcResult rpcResult = new ZLRpcResult();
        Map<String,Object> servercodeMap  = pubSrvService.getServerCodeByCode(params);
        rpcResult.setData(servercodeMap);
        return rpcResult;
    }

    public ZLRpcResult querySrvShopPage(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Page<?> pageInfo =  srvShopService.querySrvShopPage(params);
        result.setData(pageInfo);
        return result;
    }

    public ZLRpcResult updateShopfollow(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        srvShopService.updateShopfollow(params);
        return result;
    }

    public ZLRpcResult queryShopDetail(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object> shopDetail = srvShopService.queryShopDetail(params);
        result.setData(shopDetail);
        return result;
    }

    public ZLRpcResult queryBranchList(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
       Page pageInfo = srvShopService.queryBranchList(params);
        result.setData(pageInfo);
        return result;
    }

    public ZLRpcResult rechargeDetail(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> detail = srvShopService.rechargeDetail(params);
        result.setData(detail);
        return result;
    }
}
