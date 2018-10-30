package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.RoleService;
import com.wgb.service.SrvUserRoleService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import com.wgb.util.MD5Util;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SrvUserServiceImpl implements SrvUserService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.SrvUserServiceImpl.";

    protected final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private CommonDalClient dal;

    @Autowired
    private SrvUserRoleService srvUserRoleService;

    @Autowired
    private RoleService roleService;

    @Override
    public Page<?> queryUserPage(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryUserPage", params);
    }

    @Override
    public Map<String, Object> getUserInfo(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getUserInfo", params);
    }

    @Override
    public String insertUser(Map<String, Object> params) {
        Map<String, Object> userInfo = checkUserName(params);
        if (MapUtils.isNotEmpty(userInfo)) {
            return "用户名已经存在！";
        }

        //通过系统新增用户,account = shopcode + '_' + username
        params.put("account", new StringBuilder().append(MapUtils.getString(params, Contants.LOGIN_USER_SERVER_CODE)).append("_").append(MapUtils.getString(params, "username", "")));
        params.put("password", MD5Util.GetMD5Code("888888"));

        //新增用户
        Number number = dal.getDalClient().execute4PrimaryKey(NAMESPACE + "insertUser", params);
        //批量新增用户角色
        batchInsertUserRoles(params, number.toString());
        return "";
    }

    /**
     * 批量新增用户角色
     *
     * @param params
     * @param userId
     */
    private void batchInsertUserRoles(Map<String, Object> params, String userId) {
        //用户角色
        String userrole = MapUtils.getString(params, "userrole");
        if (StringUtils.isNotEmpty(userrole)) {
            String[] roleArr = userrole.split(",");
            List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>();
            for (String roleid : roleArr) {
                if (StringUtils.isNotEmpty(roleid)) {
                    Map<String, Object> p1 = new HashMap<String, Object>();
                    p1.put("userid", userId);
                    p1.put("roleid", roleid);
                    p1.put(Contants.LOGIN_USER_ID, MapUtils.getString(params, Contants.LOGIN_USER_ID));
                    paramList.add(p1);
                }
            }
            srvUserRoleService.batchInsertUserRoles(paramList);
        }
    }
    @Override
    public Map<String, Object> checkUserName(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "checkUserName", params);
    }

    @Override
    public String updateUser(Map<String, Object> params) {
        Map<String, Object> userInfo = checkUserName(params);
        if (MapUtils.isNotEmpty(userInfo)) {
            return "用户名已经存在！";
        }
        dal.getDalClient().execute(NAMESPACE + "updateUser", params);
        //当前更新用户的ID
        String userId = MapUtils.getString(params, "id");
        //先删除该用户的角色
        params.put("userid", userId);
        srvUserRoleService.deleteUserRole(params);
        //批量新增用户角色
        batchInsertUserRoles(params, userId);
        return "";
    }

    @Override
    public void undoPassword(Map<String, Object> params) {

    }

    @Override
    public int delUser(Map<String, Object> params) {
        //校验数据是否可以进行修改或删除
        checkDataRequired(params);

        // 删除用户所对应的角色
        Map<String ,Object> delParams = new HashMap<>();
        delParams.put("userid" ,MapUtils.getString(params ,"id" ,""));
        srvUserRoleService.deleteUserRoleForUserId(delParams);

        return dal.getDalClient().execute(NAMESPACE + "delUser", params);
    }


    public void resetUserPassword(Map<String, Object> params) {
        params.put("password", MD5Util.GetMD5Code("888888"));
        dal.getDalClient().execute(NAMESPACE + "resetUserPassword", params);
    }

    @Override
    public Map<String ,Object> queryServerDiscount(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryServerDiscount", params);
    }

    @Override
    public Map<String, Object> querySrvUserInfoAndRoleListById(Map<String, Object> params) {
        Map<String, Object> user = getUserInfo(params);
        return user;
    }


    private String convertListMapToString(List<Map<String, Object>> params ,String key){
        if (null != params && params.size() > 0 && StringUtils.isNotBlank(key)){
            StringBuilder sb = new StringBuilder();
            for (Map<String ,Object> param : params){
                Object obj = param.get(key);
                if (null != obj){
                    sb.append(obj).append(",");
                }
            }
            if (sb.length() > 0){
                return sb.substring(0 ,sb.length() - 1);
            }
        }
        return  "";
    }

    @Override
    public String updatePasswordForUser(Map<String, Object> params) {
        // 校验帐号密码
        Map<String ,Object> queryParams = new HashMap<>();
        queryParams.put("password" ,MapUtils.getString(params ,"oldpassword"));
        queryParams.put("account" ,MapUtils.getString(params ,"account"));
        queryParams.put("servercode" ,MapUtils.getString(params ,"servercode"));
        Integer integer = dal.getDalClient().queryForObject(NAMESPACE + "checkPasswordAndAccount", queryParams, Integer.class);
        if (integer == 0){
            return "帐号密码不正确!";
        }
        queryParams.put("password" ,MapUtils.getString(params ,"newpassword"));
        dal.getDalClient().execute(NAMESPACE + "updatePasswordForUser" ,queryParams);
        return null;
    }

    /**
     * 判断角色列表中,有哪些角色需要被选中
     *
     * @param roleList
     * @param userRoles
     */
    private void setRoleListChecked(List<Map<String, Object>> roleList, List<Map<String, Object>> userRoles) {
        if (CollectionUtils.isNotEmpty(roleList) && CollectionUtils.isNotEmpty(userRoles)) {
            for (Map<String, Object> role : roleList) {
                if (hasUserRoles(userRoles, MapUtils.getString(role, "id"))) {
                    role.put("checked", "checked");
                }
            }
        }
    }

    private boolean hasUserRoles(List<Map<String, Object>> userRoles, String roleid) {
        for (Map<String, Object> userRole : userRoles) {
            if (MapUtils.getString(userRole, "id").equals(roleid)) {
                return true;
            }
        }
        return false;
    }

    private void checkDataRequired(Map<String, Object> params) {
        //判断数据是否存在
        Map<String, Object> userInfo = getUserData(params);
        if (MapUtils.isEmpty(userInfo)) {
            throw new ServiceException(ServiceException.OPER_ERROR);
        }
        String required = MapUtils.getString(userInfo, "required", "0");
        if (Contants.DATA_REQUIRED.equals(required)) {
            throw new ServiceException(ServiceException.DEL_UPDATE_REQUIRED);
        }
    }

    @Override
    public Map<String, Object> getCurUserInfo(String account) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("account", account);
        Map<String, Object> userInfo = getLoginUser(params);
        return userInfo;
    }

    @Override
    public Map<String, Object> getLoginUser(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getLoginUser", params);
    }

    @Override
    public Map<String, Object> getUserData(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getUserData", params);
    }

    @Override
    public int checkAccount(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "checkAccount", params, Integer.class);
    }

    @Override
    public void updatePassword(Map<String, Object> params) {
        params.put("password", MD5Util.GetMD5Code(MapUtils.getString(params, "password", "")));
        dal.getDalClient().execute(NAMESPACE + "updatePassword", params);
    }

    @Override
    public Map<String, Object> getServerCodeByCode(Map<String, Object> params) {
        Map<String,Object> resultMap =  new HashMap<String,Object>();
        String regservercode = MapUtils.getString(params, "regservercode", "");
        if(StringUtils.isNotEmpty(regservercode)){
            resultMap = dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getServerCodeByCode", params);
        }
        return resultMap;
    }

}
