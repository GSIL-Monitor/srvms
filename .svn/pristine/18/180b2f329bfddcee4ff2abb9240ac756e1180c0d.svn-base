package com.wgb.service.impl.admin;

import com.wgb.cache.RedisFactory;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.admin.AdminUserService;
import com.wgb.service.dubbo.basic.admin.AdminBasicService;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by wgb on 2017/9/18 0018.
 */
@Service
public class AdminUserServiceImpl implements AdminUserService {

    @Autowired
    private AdminBasicService adminBasicService;

    @Override
    public Map<String, Object> getRemoteUserInfo(String account) {
        //存储在缓存服务器上的key
        String userKey = "admin_user_" + account;
        Map<String, Object> userInfo = null;

        //从统一redis服务器获取用户数据
        userInfo = RedisFactory.getPassportClient().getMapFromJedis(userKey);

        //如果用户不存在
        if (MapUtils.isEmpty(userInfo)) {

            //通过统一数据服务器获取用户数据
            ZLRpcResult rpcResult = adminBasicService.getUserInfo(account);
            userInfo = rpcResult.getMap();

            //如果统一数据服务器不存在该数据
            if (MapUtils.isEmpty(userInfo)) {
                return null;
            }

            //更新用户数据到redis中
            RedisFactory.getPassportClient().setMapToJedis(userInfo, userKey);
        }

        return userInfo;
    }
}
