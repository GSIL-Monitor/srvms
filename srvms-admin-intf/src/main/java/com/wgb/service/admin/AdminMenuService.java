package com.wgb.service.admin;

import java.util.List;
import java.util.Map;

public interface AdminMenuService {

    /**
     * 获得远程菜单列表
     * @param username
     * @return
     */
    List<Map<String, Object>> getRemoteMenuList(String username);
}
