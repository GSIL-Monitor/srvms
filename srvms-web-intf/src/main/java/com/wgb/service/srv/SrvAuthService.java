package com.wgb.service.srv;

import java.util.List;
import java.util.Map;

public interface SrvAuthService{
    /**
     * 根据条件查询权限
     * @param params
     * @return
     */
    List<Map<String, Object>> queryAuthListByCondition(Map<String, Object> params);

    /**
     * 修改角色权限
     * @param params
     */
    void updateAuthForRole(Map<String, Object> params);
}
