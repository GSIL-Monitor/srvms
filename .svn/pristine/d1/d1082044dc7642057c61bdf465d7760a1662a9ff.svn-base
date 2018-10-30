package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.exception.ServiceException;
import com.wgb.service.srv.SrvUserRoleService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SrvUserRoleServiceImpl implements SrvUserRoleService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.SrvUserRoleServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Override
    public void deleteUserRole(Map<String, Object> params) {
        if (StringUtils.isEmpty(MapUtils.getString(params, "userid")) && StringUtils.isEmpty(MapUtils.getString(params, "roleid"))) {
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        dal.getDalClient().execute(NAMESPACE + "deleteUserRole", params);
    }

    @Override
    public List<Map<String, Object>> getRoleListByUserId(String userId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("userid", userId);
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "getRoleListByUserId", params);
    }

    @Override
    public void batchInsertUserRoles(List<Map<String, Object>> paramList) {
        dal.getDalClient().batchUpdate(NAMESPACE + "insertUserRole", paramList.toArray(new Map[paramList.size()]));
    }

    @Override
    public void insertRegInit(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "insertRegInit", params);
    }
}


