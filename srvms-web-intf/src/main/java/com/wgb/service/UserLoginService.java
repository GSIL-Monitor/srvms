package com.wgb.service;

import java.util.Map;

/**
 * Created by pc on 2018/10/30.
 */
public interface UserLoginService {


    /**
     * 登录
     *
     * @param params
     * @return
     */
    Map<String, Object> login(Map<String, Object> params);

    /**
     * 用户登录
     * @param params
     * @return
     */
    Map<String, Object> userlogin(Map<String, Object> params);

    /**
     * 账号登录
     * @param params
     * @return
     */
    Map<String, Object> accountlogin(Map<String, Object> params);

    /**
     * 检查账号/用户/密码是否存在
     *
     * @param params
     * @return
     */
    int checkExist(Map<String, Object> params);

    /**
     * 检查字符合法性并且重新封装密码
     *
     * @param params
     * @return
     */
    Map<String, Object> checkIegal(Map<String, Object> params);
}
