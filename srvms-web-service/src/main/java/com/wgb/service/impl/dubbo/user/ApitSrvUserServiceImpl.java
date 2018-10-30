package com.wgb.service.impl.dubbo.user;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitSrvUserService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.MD5Util;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 10:52
 **/
@Service
public class ApitSrvUserServiceImpl implements ApitSrvUserService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitSrvUserServiceImpl.class);

    @Autowired
    private SrvUserService srvUserService;

    public ZLRpcResult queryUserPage(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
            //获取用户数据
        Page<?> pageInfo = srvUserService.queryUserPage(params);
        result.setData(pageInfo);
        return result;
    }

    public ZLRpcResult delUser(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String id = MapUtils.getString(params, "id", "");
        if (StringUtils.isNotEmpty(id)) {
            int i = srvUserService.delUser(params);
        } else {
            result.setErrorMsg("缺失参数id！");
        }
        return result;
    }

    public ZLRpcResult resetUserPassword(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String id = MapUtils.getString(params, "id", "");
        if (StringUtils.isNotEmpty(id)) {
            srvUserService.resetUserPassword(params);
        } else {
            result.setErrorMsg("缺失参数id！");
        }
        return result;
    }

    public ZLRpcResult saveUser(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String message = srvUserService.insertUser(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }

    public ZLRpcResult querySrvUserInfoAndRoleListById(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String id = MapUtils.getString(params, "id", "");
        if (StringUtils.isNotEmpty(id)) {
            Map<String, Object> user = srvUserService.querySrvUserInfoAndRoleListById(params);
            result.setData(user);
        } else {
            result.setErrorMsg("缺失参数id！");
        }
        return result;
    }

    public ZLRpcResult updateUser(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        //更新用户信息
        String message = srvUserService.updateUser(params);
        if (StringUtils.isNotBlank(message)){result.setErrorMsg(message);}
        return result;
    }

    public ZLRpcResult getCurUserInfo(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object> userInfo = srvUserService.getCurUserInfo(MapUtils.getString(params, "account"));
        result.setData(userInfo);
        return result;
    }

    public ZLRpcResult getLoginUserInfo(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        // 校验帐号密码
        boolean checkResult = checkLoginUserInfo(params);
        if (!checkResult){
            result.setErrorMsg("用户名或密码不能为空!");
            return result;
        }
        Map<String, Object> userInfo = srvUserService.getLoginUser(params);
        result.setData(userInfo);
        return result;
    }

    private boolean checkLoginUserInfo(Map<String, Object> params) {
        String account = MapUtils.getString(params, "account","");
        String username = MapUtils.getString(params, "username","");
        String servercode = MapUtils.getString(params, "servercode","");
        String password = MapUtils.getString(params, "password","");
        if(StringUtils.isNotBlank(account) && StringUtils.isNotBlank(password)){
            return true;
        }else if(StringUtils.isNotBlank(servercode) && StringUtils.isNotBlank(username) && StringUtils.isNotBlank(password)){
            return true;
        }
        return false;
    }

    public ZLRpcResult updatePasswordForUser(Map<String ,Object> params){
        ZLRpcResult result = new ZLRpcResult();
        String message =  srvUserService.updatePasswordForUser(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }
}
