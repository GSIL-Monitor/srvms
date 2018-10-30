package com.wgb.controller.srv;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.RoleService;
import com.wgb.util.Contants;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(RoleController.class);

    @Autowired
    private RoleService roleService;

    @RequestMapping("/queryRolePage")
    public ZLResult queryRolePage(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Page<?> pageInfo = roleService.getRolePage(params);
            result.setData(pageInfo);
        }catch (ServiceException ex){
            LOGGER.error("查询服务商所有角色业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("查询服务商所有角色系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    /**
     * 查询当前服务商所有权限
     * @param request
     * @return
     */
    @RequestMapping("/queryRoleList")
    @ResponseBody
    public ZLResult queryRoleList(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            List<Map<String, Object>> roleList = roleService.queryRoleList(params);
            result.setData(roleList);
        }catch (ServiceException ex){
            LOGGER.error("查询服务商角色业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("查询服务商角色系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    /**
     * 删除用户角色
     * @param request
     * @return
     */
    @RequestMapping("/delRole")
    @ResponseBody
    public ZLResult delRole(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            String message = roleService.delRole(params);
            if (StringUtils.isNotBlank(message)) {
               result = ZLResult.Error(message);
            }
        }catch (ServiceException ex){
            LOGGER.error("删除服务商角色业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("删除服务商角色系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    /**
     * 保存服务商角色
     * @param request
     * @return
     */
    @RequestMapping("/saveRole")
    @ResponseBody
    public ZLResult saveRole(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            int count = roleService.getRoleCount(params);
            if (count > 0) {
                result = ZLResult.Error("角色已存在!");
            }
            roleService.insertRole(params);
        }catch (ServiceException ex){
            LOGGER.error("保存服务商角色业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("保存服务商角色系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    /**
     * 修改服务商角色名称查询角色
     * @param request
     * @return
     */
    @RequestMapping("/queryRoleNameForUpdate")
    @ResponseBody
    public ZLResult queryRoleNameForUpdate(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String, Object> role = roleService.queryRoleNameForUpdate(params);
            result.setData(role);
        }catch (ServiceException ex){
            LOGGER.error("查询服务商角色名称业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("查询服务商角色名称系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    /**
     * 修改服务商角色名称
     * @param request
     * @return
     */
    @RequestMapping("/updateRole")
    @ResponseBody
    public ZLResult updateRole(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            int count = roleService.getRoleCount(params);
            if (count > 0) {
                result = ZLResult.Error("角色已经存在");
            }
            roleService.updateRoleName(params);
        }catch (ServiceException ex){
            LOGGER.error("修改服务商角色名称业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("修改服务商角色名称系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }







    @RequestMapping("/query")
    @ResponseBody
    public ZLResult query(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        Page<?> pageInfo = roleService.getRolePage(params);
        return ZLResult.Success(pageInfo);
    }

    /**
     * 2.0查找角色
     *
     * @param request
     * @return
     */
    @RequestMapping("/select")
    @ResponseBody
    public ZLResult select(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        Map<String, Object> roleObject = new HashMap<String, Object>();
        List<Map<String, Object>> rolelist = roleService.selectRoleList(params);
        roleObject.put("detailList", rolelist);
        return ZLResult.Success(roleObject);
    }










    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public ZLResult saveOrUpdate(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        roleService.saveOrUpdate(params);
        // cacheService.updateCache(CacheConstant.CACHE_SHOP_ROLE_LIST, MapUtils.getString(params, Contants.LOGIN_USER_SHOP_CODE));
        return ZLResult.Success();
    }

}
