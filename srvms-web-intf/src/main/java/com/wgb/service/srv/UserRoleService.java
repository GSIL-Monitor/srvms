package com.wgb.service.srv;

import java.util.Map;

public interface UserRoleService {

    /**
     * 添加角色
     * @param params
     */
    void insertUserRoles(Map<String, Object> params);

    /**
     * 删除角色
     * @param params
     */
    void deleteUserRoles(Map<String, Object> params);

}
