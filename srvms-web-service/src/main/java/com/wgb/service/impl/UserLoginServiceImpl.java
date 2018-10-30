package com.wgb.service.impl;

import com.aliyun.oss.ServiceException;
import com.wgb.dao.CommonDalClient;
import com.wgb.service.UserLoginService;
import com.wgb.util.MD5Util;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by pc on 2018/10/30.
 */
@Service
public class UserLoginServiceImpl implements UserLoginService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.UserLoginServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Override
    public Map<String, Object> login(Map<String, Object> params) {
        params = checkIegal(params);
        int count = checkExist(params);
        String type = MapUtils.getString(params, "type");
        Map<String, Object> userInfo = null;
        if (count != 1) {
           throw new ServiceException("用户不存在或已被删除或密码错误");
        }else{
            if (StringUtils.isEmpty(type)) {
                userInfo = userlogin(params);
            } else {
                userInfo = accountlogin(params);
            }
        }
        return userInfo;
    }

    @Override
    public Map<String, Object> userlogin(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "userlogin", params);
    }

    @Override
    public Map<String, Object> accountlogin(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "accountlogin", params);
    }

    @Override
    public int checkExist(Map<String, Object> params) {

        return dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "checkExist", params, Integer.class);
    }

    @Override
    public Map<String, Object> checkIegal(Map<String, Object> params) {
        String type = MapUtils.getString(params, "type");
        String account = MapUtils.getString(params, "account");
        String password1 = MapUtils.getString(params, "password1");
        String password2 = MapUtils.getString(params, "password2");
        String username = MapUtils.getString(params, "username");
        String servserid = MapUtils.getString(params, "serverid");
        if (StringUtils.isEmpty(type)) {
            if (StringUtils.isEmpty(username) || StringUtils.isEmpty(servserid) || StringUtils.isEmpty(password2)) {
                throw new ServiceException("用户或服务商或密码不能为空");
            } else {
                params.put("username", username);
                params.put("servserid", servserid);
                params.put("password", MD5Util.GetMD5Code(password2));
            }

        } else {
            if (StringUtils.isEmpty(account) || StringUtils.isEmpty(password1)) {
                throw new ServiceException("账号或密码不能为空");
            } else {
                params.put("password", MD5Util.GetMD5Code(password1));
                params.put("account", account);
            }
        }
        return params;
    }


}
