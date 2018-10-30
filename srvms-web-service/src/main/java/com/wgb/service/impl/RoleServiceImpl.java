package com.wgb.service.impl;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.CacheDataService;
import com.wgb.service.RoleService;
import com.wgb.util.Contants;
import net.sf.json.JSONArray;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl extends BaseServiceImpl implements RoleService, CacheDataService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.RoleServiceImpl.";


    private static final int BUSINESS_CODE_MIN_LENGTH = 4;

    @Autowired
    private CommonDalClient dal;

    public List<Map<String, Object>> queryRoleList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryRoleList", params);
    }

    @Override
    public Page<?> getRolePage(Map<String, Object> params) {
        Page<?> pageInfo = dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryRoleList", params);
        return pageInfo;
    }

    @Override
    public List<Map<String, Object>> selectRoleList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryRoleList", params);
    }



    @Override
    public Page<?> getRolePageForAuth(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryRoleList", params);
    }

    @Override
    public Map<String, Object> getRole(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryRoleList", params);
    }
    @Override
    public List<Map<String, Object>> getRoleList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryRoleList", params);
    }


    @Override
    public int getRoleCount(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "getRoleCount", params, Integer.class);
    }

    @Override
    public String insertRole(Map<String, Object> params) {
        int count = getRoleCount(params);
        if (count > 0) {
           return "角色已存在!";
        }
        params.put("rolecode", generateBranchUniqueBusinessCode(NAMESPACE, params, BUSINESS_CODE_MIN_LENGTH));
        params.put("del","0");
        params.put("cangrant","1");
        dal.getDalClient().execute4PrimaryKey(NAMESPACE + "insertRole", params);
        return "";
    }


    private String checkDataRequired(Map<String, Object> params) {

        Map<String, Object> role = getRoleInfo(params);

        if (getRoleIsusedNum(params)>0) {
            return "用户正在使用该角色,无法删除";
        }

        if (MapUtils.isEmpty(role)) {
            return "角色已不存在";
        }

        String required = MapUtils.getString(role, "required", "0");
        if (Contants.DATA_REQUIRED.equals(required)) {
            return "角色被需求无法被删除";
        }
        return "";
    }

    private Map<String, Object> getRoleInfo(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryRoleList", params);
    }

    private int getRoleIsusedNum(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "getRoleIsusedNum", params,Integer.class);
    }

    @Override
    public String delRole(Map<String, Object> params) {
        String message = checkDataRequired(params);
        if(StringUtils.isNotEmpty(message)){
            return message;
        }
        dal.getDalClient().execute(NAMESPACE + "delRole", params);
        return "";
    }

    @Override
    public void updateRole(Map<String, Object> params) {
        String id = MapUtils.getString(params, "roleid");
        if (StringUtils.isEmpty(id)) {
            params.put("rolecode", generateBranchUniqueBusinessCode(NAMESPACE, params, BUSINESS_CODE_MIN_LENGTH));
            dal.getDalClient().execute4PrimaryKey(NAMESPACE + "insertRole", params);
        } else {
            dal.getDalClient().execute(NAMESPACE + "updateRole", params);
        }
    }

    public void updateRoleName(Map<String, Object> params) {
        String id = MapUtils.getString(params, "roleid");
        if (StringUtils.isEmpty(id)) {
            params.put("rolecode", generateBranchUniqueBusinessCode(NAMESPACE, params, BUSINESS_CODE_MIN_LENGTH));
            dal.getDalClient().execute4PrimaryKey(NAMESPACE + "insertRole", params);
        } else {
            dal.getDalClient().execute(NAMESPACE + "updateRoleName", params);
        }
    }

    public Map<String, Object> queryRoleNameForUpdate(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryRoleNameForUpdate", params);
    }


    @Override
    public Map<String, Object> getCacheMap(Map<String, Object> params) {
        return null;
    }

    @Override
    public List<Map<String, Object>> getCacheList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryRoleList", params);
    }

    @Override
    public String saveOrUpdate(Map<String, Object> params) {

        checkDataRequired(params);
        String meunlist = MapUtils.getString(params, "meunlist");
        if (StringUtils.isEmpty(meunlist)) {
            throw new ServiceException(ServiceException.PARAM_ERROR);
        }
        JSONArray meunlistjsonarr = JSONArray.fromObject(meunlist);
        StringBuilder menus = new StringBuilder("");
        for (int index = 0; index < meunlistjsonarr.size(); index++) {
            if (StringUtils.isNotEmpty(menus.toString())) {
                menus.append(",");
            }
            menus.append(meunlistjsonarr.getString(index));
        }
        params.put("menus",menus);
        dal.getDalClient().execute(NAMESPACE + "updateRole", params);

        return "";
    }
}
