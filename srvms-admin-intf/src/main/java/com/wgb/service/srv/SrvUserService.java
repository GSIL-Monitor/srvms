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
    void updateUser(Map<String, Object> params);

    /**
     * 删除用户
     * @param params
     */
    void delUser(Map<String, Object> params);

    String addRegUser(Map<String, Object> params);

    int checkSrvTel(Map<String, Object> params);

    void updateSrvUser(Map<String, Object> params);
}
