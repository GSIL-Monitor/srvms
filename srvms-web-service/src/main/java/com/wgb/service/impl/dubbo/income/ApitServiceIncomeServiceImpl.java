package com.wgb.service.impl.dubbo.income;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitServiceIncomeService;
import com.wgb.service.income.ServiceIncomeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-30 16:13
 **/
@Service
public class ApitServiceIncomeServiceImpl implements ApitServiceIncomeService {
    @Autowired
    private ServiceIncomeService serviceIncomeService;

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitServiceIncomeServiceImpl.class);

    public ZLRpcResult showShopTable(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Page<?> pageInfo = serviceIncomeService.showShopTable(params);
        result.setData(pageInfo);
        return result;
    }
}
