package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.service.srv.PubSrvService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class PubSrvServiceImpl implements PubSrvService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.PubSrvServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Override
    public Map<String, Object> queryService(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryService", params);
    }

    public Map<String, Object> querySrvDetails(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "querySrvDetails", params);
    }

    @Override
    public Map<String, Object> getServerCodeByCode(Map<String, Object> params) {
        Map<String,Object> resultMap =  new HashMap<String,Object>();
        String regservercode = MapUtils.getString(params, "regservercode", "");
        if(StringUtils.isNotEmpty(regservercode)){
            resultMap = dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getServerCodeByCode", params);
        }
        return resultMap;
    }
}
