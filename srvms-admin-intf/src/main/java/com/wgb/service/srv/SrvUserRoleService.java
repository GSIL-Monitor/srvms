package com.wgb.service.srv;

import java.util.List;
import java.util.Map;

public interface SrvUserRoleService {

    void deleteUserRole(Map<String, Object> params);

    List<Map<String, Object>> getRoleListByUserId(String userId);

    void batchInsertUserRoles(List<Map<String, Object>> paramList);

    void insertRegInit(Map<String, Object> params);
}
