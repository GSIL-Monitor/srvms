package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.exception.ServiceException;
import com.wgb.service.srv.UserRoleService;
import com.wgb.util.Contants;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserRoleServiceImpl implements UserRoleService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.UserRoleServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    public void insertUserRoles(Map<String, Object> params) {
        String userId = MapUtils.getString(params, "id", "");
        String roleIds = MapUtils.getString(params, "roleIds", "");
        String loginUserId = MapUtils.getString(params, Contants.LOGIN_USER_ID, "");
        String[] roleIdArr = roleIds.split(",");

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("userid", userId);
        //删除用户所有的菜单数据
        deleteUserRole(param);

        if (roleIdArr != null && roleIdArr.length > 0) {
            List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>();
            for (String roleId : roleIdArr) {
                if (StringUtils.isEmpty(roleId)) {
                    continue;
                }
                Map<String, Object> temp = new HashMap<String, Object>();
                temp.put("userid", userId);
                temp.put("roleid", roleId);
                temp.put(Contants.LOGIN_USER_ID, loginUserId);
                paramList.add(temp);
            }

            dal.getDalClient().batchUpdate(NAMESPACE + "insertUserRole", paramList.toArray(new Map[paramList.size()]));
        }
    }

    public void deleteUserRoles(Map<String, Object> params) {
        String roleIds = MapUtils.getString(params, "roleIds", "");
        String userId = MapUtils.getString(params, "userId", "");
        String[] roleIdArr = roleIds.split(",");

        for (String roleId : roleIdArr) {
            Map<String, Object> param = new HashMap<String, Object>();
            param.put("userid", userId);
            param.put("roleid", roleId);
            deleteUserRole(param);
        }
    }

    private void deleteUserRole(Map<String, Object> params) {
        if (StringUtils.isEmpty(MapUtils.getString(params, "userid")) && StringUtils.isEmpty(MapUtils.getString(params, "roleid"))) {
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        dal.getDalClient().execute(NAMESPACE + "deleteUserRole", params);
    }

}
