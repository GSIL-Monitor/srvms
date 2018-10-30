package com.wgb.service;

import java.util.List;
import java.util.Map;

public interface SrvUserRoleService {

    /**
     * 删除用户下的角色
     * @param params
     */
    void deleteUserRole(Map<String, Object> params);

    /**
     * 通过用户id获得所拥有的角色列表
     * @param userId
     * @return
     */
    List<Map<String, Object>> getRoleListByUserId(Map<String, Object> userId);

    /**
     * 在用户下添加多个角色
     * @param paramList
     */
    void batchInsertUserRoles(List<Map<String, Object>> paramList);

    /**
     * 获得角色列表通过服务商
     * @param params
     * @return
     */
    List<Map<String,Object>> getRoleListForServer(Map<String, Object> params);

    /**
     * 根据 userid 删除用户角色关联关系
     * @param params
     */
    void deleteUserRoleForUserId(Map<String, Object> params);
}
