package com.wgb.service.impl;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.IndustryService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-30 16:30
 **/
@Service
public class IndustryServiceImpl implements IndustryService {

    @Autowired
    private ApiShopService apiShopService;

    public List<Map<String, Object>> getIndustryList(Map<String, Object> params) {
        ZLRpcResult rpcResult = apiShopService.getIndustryList(params);
        List<Map<String, Object>> indestryList = new ArrayList<>();
        Map<String, Object> indestryMap = new HashMap<String, Object>();
        indestryMap.put("id", "");
        indestryMap.put("name", "全部");
        indestryList.add(indestryMap);
        indestryList.addAll(rpcResult.getList());
        return indestryList;
    }
}
