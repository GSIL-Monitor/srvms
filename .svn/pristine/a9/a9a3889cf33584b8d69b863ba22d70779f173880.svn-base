package com.wgb.service.srv;

import com.wgb.dao.Page;

import java.util.Map;

public interface SrvUserService {
    /**
     * 获取用户登录信息
     * @param username
     * @return
     */
    Map<String, Object> getCurUserInfo(String username);

    /**
     * 用户登录
     * @param params
     * @return
     */
    Map<String,Object> getLoginUser(Map<String, Object> params);

    Map<String, Object> getUserData(Map<String, Object> params);

    /**
     * 校验用户是否存在
     * @param params
     * @return
     */
    int checkAccount(Map<String, Object> params);

    /**
     * 更新密码
     * @param params
     */
    void updatePassword(Map<String, Object> params);

    /**
     * 获取用户分页列表信息
     * @param params
     * @return
     */
    Page<?> queryUserPage(Map<String, Object> params);

    /**
     * 获取用户信息
     * @param params
     * @return
     */
    Map<String,Object> getUserInfo(Map<String, Object> params);

    /**
     * 添加用户
     * @param params
     * @return
     */
    String insertUser(Map<String, Object> params);

    /**
     * 校验用户名参数
     * @param params
     * @return
     */
    Map<String, Object> checkUserName(Map<String, Object> params);

    /**
     * 更新用户
     * @param params
     */
    String updateUser(Map<String, Object> params);

    /**
     * 更新密码
     * @param params
     */
    void undoPassword(Map<String, Object> params);

    /**
     * 删除用户
     * @param params
     */
    int delUser(Map<String, Object> params);

    /**
     * 重置密码
     * @param params
     */
    void resetUserPassword(Map<String, Object> params);

    /**
     * 通过编码查供应商编码
     * @param params
     * @return
     */
    Map<String,Object> getServerCodeByCode(Map<String, Object> params);

    /**
     *  获取服务商应用折扣
     * @param params
     */
    Map<String ,Object> queryServerDiscount(Map<String, Object> params);

    /**
     * 查询用户信息，并查询服务商角色信息
     * @param params
     * @return
     */
    Map<String,Object> querySrvUserInfoAndRoleListById(Map<String, Object> params);

    String updatePasswordForUser(Map<String, Object> params);
}
