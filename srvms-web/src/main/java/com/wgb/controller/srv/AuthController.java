package com.wgb.controller.srv;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.CacheService;
import com.wgb.service.RoleService;
import com.wgb.service.srv.SrvAuthService;
import com.wgb.service.srv.UserRoleService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 权限Controller类
 */
@Controller
@RequestMapping("/auth")
public class AuthController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(RoleController.class);

    @Autowired
    private SrvAuthService srvAuthService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserRoleService userRoleService;


    @Autowired
    private CacheService cacheService;

    @RequestMapping("/queryAuthByRoleId")
    @ResponseBody
    public ZLResult queryAuthByRoleId(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            String id = MapUtils.getString(params, "roleid", "");
            if (StringUtils.isNotEmpty(id)) {
                List<Map<String, Object>> authList = srvAuthService.queryAuthListByCondition(params);
                result.setData(authList);
            } else {
                result = ZLResult.Error("缺失参数RoleId");
            }
        }catch (ServiceException ex){
            LOGGER.error("查询服务商所有角色业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("查询服务商所有角色系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    @RequestMapping("/updateAuth")
    @ResponseBody
    public ZLResult update(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            roleService.updateRole(params);
        }catch (ServiceException ex){
            LOGGER.error("修改角色权限业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("修改角色权限系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }


    @RequestMapping("/manage")
    public String manage(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        params.put("cangrant","1"); // 是否可编辑
        Page<?> pageInfo = roleService.getRolePageForAuth(params);
        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "system/auth_manage";
    }

    @RequestMapping("/addUserRole")
    @ResponseBody
    public String addUserRole(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        userRoleService.insertUserRoles(params);
        return "success";
    }

    @RequestMapping("/delUserRole")
    @ResponseBody
    public String delUserRole(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        userRoleService.deleteUserRoles(params);
        return "success";
    }







    @RequestMapping("/updateDetail")
    @ResponseBody
    public String updateMenu(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        roleService.updateRole(params);
        return "";
    }
}
