package com.wgb.service.impl;

import com.wgb.dao.CommonDalClient;
import com.wgb.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

/**
 * Created by wgb on 2017/3/6.
 */
public abstract class BaseServiceImpl {

    @Autowired
    protected CommonDalClient dal;

    protected String generateShopUniqueBusinessCode(String NAMESPACE, Map<String, Object> params, int min) {
        Integer integer = dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "generateShopUniqueBusinessCode", params, Integer.class);
        return CommonUtil.generateCode(integer, min);
    }

    protected String generateBranchUniqueBusinessCode(String NAMESPACE, Map<String, Object> params, int min) {
        Integer integer = dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "generateBranchUniqueBusinessCode", params, Integer.class);
        return CommonUtil.generateCode(integer, min);
    }


}
