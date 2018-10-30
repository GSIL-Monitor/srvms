package com.wgb.service.impl.admin;

import com.wgb.cache.RedisFactory;
import com.wgb.dao.CommonDalClient;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.admin.AdminMenuService;
import com.wgb.service.dubbo.basic.admin.AdminBasicService;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AdminMenuServiceImpl implements AdminMenuService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.admin.AdminMenuServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Autowired
    private AdminBasicService adminBasicService;

    public List<Map<String, Object>> getRemoteMenuList(String account) {
        //存储在缓存服务器上的key
        String menuKey = "admin_menu_" + account;
        List<Map<String, Object>> menuList = RedisFactory.getPassportClient().getListFromJedis(menuKey);
        if (CollectionUtils.isEmpty(menuList)) {
            ZLRpcResult rpcResult = adminBasicService.getMenuList(account);
            menuList = rpcResult.getList();
            //更新用户数据到redis中
            RedisFactory.getPassportClient().setListToJedis(menuList, menuKey);
        }
        return menuList;
    }
}
