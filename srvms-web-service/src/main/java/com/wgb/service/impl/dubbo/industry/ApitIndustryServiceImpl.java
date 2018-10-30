package com.wgb.service.impl.dubbo.industry;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitIndustryService;
import com.wgb.service.industry.IndustryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-30 16:30
 **/
@Service
public class ApitIndustryServiceImpl implements ApitIndustryService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitIndustryServiceImpl.class);

    @Autowired
    private IndustryService industryService;

    public ZLRpcResult getList(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> industryList = industryService.getIndustryList(params);
        result.setData(industryList);
        return result;
    }
}
