package com.wgb.controller.srv;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.RoleService;
import com.wgb.service.SrvUserRoleService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.omg.CORBA.OBJECT_NOT_EXIST;
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
/**
 * Created by yjw on 2017/11/8.
 */
@Controller
@RequestMapping("/srv/user")
public class SrvUserController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(SrvUserController.class);

    @Autowired
    private SrvUserService srvUserService;

    /**
     * 获取用户分页列表数据
     * @param request
     * @return
     */
    @RequestMapping("/queryUserPage")
    @ResponseBody
    public ZLResult queryUserPage(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            //获取用户数据
            Page<?> pageInfo = srvUserService.queryUserPage(params);
            result.setData(pageInfo);
        }catch (ServiceException ex){
            LOGGER.error("查询服务商用户列表业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("查询服务商用户列表系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }


    /**
     * 删除用户
     * @param request
     * @return
     */
    @RequestMapping("/delUser")
    @ResponseBody
    public ZLResult delUser(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            String id = MapUtils.getString(params, "id", "");
            if (StringUtils.isNotEmpty(id)) {
                int i = srvUserService.delUser(params);
            } else {
                result = ZLResult.Error("缺失参数id！");
            }
        }catch (ServiceException ex){
            LOGGER.error("删除服务商用户信息业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("删除服务商用户信息系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    /**
     * 重置用户密码
     * @param request
     * @return
     */
    @RequestMapping("/resetUserPassword")
    @ResponseBody
    public ZLResult resetUserPassword(HttpServletRequest request) {

        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            String id = MapUtils.getString(params, "id", "");
            if (StringUtils.isNotEmpty(id)) {
                srvUserService.resetUserPassword(params);
            } else {
                result = ZLResult.Error("缺失参数id！");
            }
        }catch (ServiceException ex){
            LOGGER.error("重置服务商用户密码业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("重置服务商用户密码系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    /**
     * 新增用户
     * @param request
     * @return
     */
    @RequestMapping("/saveUser")
    @ResponseBody
    public ZLResult saveUser(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            String message = srvUserService.insertUser(params);
            if (StringUtils.isNotBlank(message)){
                result = ZLResult.Error(message);
            }
        }catch (ServiceException ex){
            LOGGER.error("新增服务商用户业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("新增服务商用户系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    /**
     * 查询修改服务商商户详情资料
     * @param request
     * @return
     */
    @RequestMapping("/querySrvUserInfoAndRoleListById")
    @ResponseBody
    public ZLResult querySrvUserInfoAndRoleListById(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            String id = MapUtils.getString(params, "id", "");
            if (StringUtils.isNotEmpty(id)) {
                Map<String, Object> user = srvUserService.querySrvUserInfoAndRoleListById(params);
                result.setData(user);
            } else {
                result = ZLResult.Error("缺失参数id！");
            }
        }catch (ServiceException ex){
            LOGGER.error("查询服务商修改用户详情业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("查询服务商修改用户详情系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }

    /**
     * 更新用户
     * @param request
     * @return
     */
    @RequestMapping("/updateSrvUser")
    @ResponseBody
    public ZLResult update(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            //更新用户信息
            srvUserService.updateUser(params);
        }catch (ServiceException ex){
            LOGGER.error("查询服务商修改用户详情业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("查询服务商修改用户详情系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }



    /**
     * 重置密码
     * @param request
     * @return
     */
    @RequestMapping("/undoPassword")
    @ResponseBody
    public String undoPassword(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        srvUserService.undoPassword(params);
        return "";
    }

}
