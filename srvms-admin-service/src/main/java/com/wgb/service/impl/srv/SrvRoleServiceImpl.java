package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.service.srv.SrvRoleService;
import com.wgb.service.srv.SrvShopService;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class SrvRoleServiceImpl implements SrvRoleService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.SrvRoleServiceImpl.";

    protected final Logger logger = LoggerFactory.getLogger(SrvRoleServiceImpl.class);

    @Autowired
    private CommonDalClient dal;


    @Override
    public String insertRegInit(Map<String, Object> params) {
        Number number = dal.getDalClient().execute4PrimaryKey(NAMESPACE + "insertRegInit", params);
        return number.toString();
    }
}
