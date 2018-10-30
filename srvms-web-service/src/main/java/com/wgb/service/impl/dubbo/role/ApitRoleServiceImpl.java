package com.wgb.service.impl.dubbo.role;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.RoleService;
import com.wgb.service.dubbo.srvms.web.ApitRoleService;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 11:00
 **/
@Service
public class ApitRoleServiceImpl implements ApitRoleService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ApitRoleServiceImpl.class);

    @Autowired
    private RoleService roleService;

    public ZLRpcResult queryRolePage(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Page<?> pageInfo = roleService.getRolePage(params);
        result.setData(pageInfo);
        return result;
    }


    public ZLRpcResult queryRoleList(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> roleList = roleService.queryRoleList(params);
        result.setData(roleList);
        return result;
    }


    public ZLRpcResult delRole(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String message = roleService.delRole(params);
        if (StringUtils.isNotBlank(message)) {
           result.setErrorMsg(message);
        }
        return result;
    }


    public ZLRpcResult saveRole(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String message = roleService.insertRole(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }

    public ZLRpcResult queryRoleNameForUpdate(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object> role = roleService.queryRoleNameForUpdate(params);
        result.setData(role);
        return result;
    }

    public ZLRpcResult updateRole(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        int count = roleService.getRoleCount(params);
        if (count > 0) {
            result.setErrorMsg("角色已经存在");
        }
        roleService.updateRoleName(params);
        return result;
    }
}
