package com.wgb.service;

import com.wgb.dao.Page;

import java.util.List;
import java.util.Map;

public interface RoleService {

    /**
     * 查询该服务商下的所有的角色
     * @param params
     * @return
     */
    List<Map<String, Object>> queryRoleList(Map<String, Object> params);

    /**
     * 角色列表查询
     * @return
     */
    Page<?> getRolePage(Map<String, Object> params);

    /**
     * 角色列表权限
     * @return
     */
    Page<?> getRolePageForAuth(Map<String, Object> params);

    /**
     * 添加角色
     * @param params
     * @return
     */
    String insertRole(Map<String, Object> params);

    /**
     * 删除角色
     * @param params
     */
    String delRole(Map<String, Object> params);

    /**
     * 修改角色信息
     * @param params
     */
    void updateRole(Map<String, Object> params);

    /**
     * 选中角色
     * @param params
     * @return
     */
    Map<String, Object> getRole(Map<String, Object> params);


    /**
     *
     * @param params
     * @return
     */
    List<Map<String, Object>> getRoleList(Map<String, Object> params);

    /**
     * 查询所有角色数量
     * @param params
     * @return
     */
    int getRoleCount(Map<String, Object> params);

    /**
     * 保存或修改
     * @param params
     * @return
     */
    String saveOrUpdate(Map<String, Object> params);

    /**
     * 选择角色列表
     * @param params
     * @return
     */
    List<Map<String, Object>> selectRoleList(Map<String, Object> params);

    /**
     * 修改角色名称
     * @param params
     */
    void updateRoleName(Map<String, Object> params);

    /**
     *  根据id 查询服务商角色名称/code
     * @param params
     * @return
     */
    Map<String,Object> queryRoleNameForUpdate(Map<String, Object> params);
}
