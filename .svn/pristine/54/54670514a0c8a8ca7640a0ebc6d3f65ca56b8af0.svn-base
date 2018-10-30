package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.urms.web.ApitShopService;
import com.wgb.service.srv.SrvShopService;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class SrvShopServiceImpl implements SrvShopService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.SrvShopServiceImpl.";

    protected final Logger logger = LoggerFactory.getLogger(SrvShopServiceImpl.class);

    @Autowired
    private CommonDalClient dal;

    @Autowired
    private ApitShopService apitShopService;

    @Override
    public Map<String, Object> getShopCountMap(String servercode) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("servercode", servercode);
    //    Map<String, Object> srvRegShopMap = dal.getDalClient().queryForMap(NAMESPACE + "querySrvRegShopCount", params);
        Map<String, Object> associationShopMap = dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "querySrvAssociationShopCount", params);

        Map<String, Object> data = new HashMap<String, Object>();
   //     data.put("srvregshop", MapUtils.getString(srvRegShopMap, "srvregshop"));
        data.put("associationshop", MapUtils.getString(associationShopMap, "associationshop"));
        return data;
    }

    @Override
    public Map<String, Object> getAssociationSrv(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getAssociationSrv", params);
    }

    @Override
    public void addSrvShop(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "addSrvShop", params);
    }

    @Override
    public Map<String, Object> getServercode(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getServercode", params);
    }

    @Override
    public Map<String, Object> getSrvShopInfo(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getSrvShopInfo", params);
    }

    @Override
    public Page<?> findSrvShopForPage(Map<String, Object> params) {
        try {
            ZLRpcResult rpcResult = apitShopService.queryShopListForSrvmsForSlave(params);
            if (null != rpcResult && rpcResult.success()){
                return (Page<?>)rpcResult.getData();
            }
            logger.info("查询服务商下商户信息异常!{}", rpcResult.getErrorMsg());
            throw new ServiceException(rpcResult.getErrorMsg());
        } catch (Exception ex){
            logger.error("查询服务商下商户信息异常！", ex);
            throw new ServiceException("操作异常，请联系管理员!");
        }
    }

}
