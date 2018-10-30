package com.wgb.service.impl.dubbo.home;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitHomeService;
import com.wgb.service.home.HomeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-10-08 10:58
 **/
@Service
public class ApitHomeServiceImpl implements ApitHomeService {

    @Autowired
    private HomeService homeService;

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitHomeServiceImpl.class);

    public ZLRpcResult index(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String ,Object> indexInfo = homeService.queryIndexInfo(params);
        result.setData(indexInfo);
        return result;
    }

    public ZLRpcResult getExpireBranchCount(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        int maturityStoreNums = homeService.getExpireBranchCount(params);
        result.setData(maturityStoreNums);
        return result;
    }

    public ZLRpcResult getStoreCount(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object> storeCount = homeService.getStoreCount(params);
        result.setData(storeCount);
        return result;
    }
}
