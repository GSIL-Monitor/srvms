package com.wgb.controller;

import com.wgb.exception.ServiceException;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.*;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.EnvironmentAware;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yjw on 2017/11/17.
 */
@Controller
@RequestMapping("/login")
public class LoginController extends BaseController implements EnvironmentAware{

    private Environment environment;

    @Autowired
    private SrvUserService srvUserService;

    @RequestMapping("/entry/login")
    @ResponseBody
    public Map<String, Object> login(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();
        String errorMsg = null;
        Map<String, Object> userInfo = null;

        Map<String, Object> params = getParams();
        String account = MapUtils.getString(params, "account");
        String password1 = MD5Util.GetMD5Code(MapUtils.getString(params, "password1"));
        String password2 = MD5Util.GetMD5Code(MapUtils.getString(params, "password2"));
        String username = MapUtils.getString(params, "username");
        String serverid = MapUtils.getString(params, "serverid");
        String type = MapUtils.getString(params, "type");

        if (StringUtils.isNotEmpty(type)) {
            if (StringUtils.isEmpty(account) || StringUtils.isEmpty(password1)) {
                errorMsg = "用户名或密码不能为空!";
            } else {

                Map<String, Object> result = new HashMap<String, Object>();
                result.put("account", account);
                result.put("password", password1);

                try {
                    userInfo = srvUserService.getLoginUser(result);

                    if (MapUtils.isEmpty(userInfo)) {
                        errorMsg = "账号不存在或密码错误";
                    }else{
                        String flag = MapUtils.getString(userInfo, "flag");
                        if (flag.equals("0")) {
                            errorMsg = "账号已被禁用!";
                        } else {
                            session.setAttribute("userInfo", userInfo);
                        }
                    }


                } catch (ServiceException e) {
                    errorMsg = "系统异常！";
                }
            }

        } else {
            if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password2) || StringUtils.isEmpty(serverid)) {
                errorMsg = "用户名或密码或服务商ID不能为空!";
            } else {

                Map<String, Object> result = new HashMap<String, Object>();
                result.put("username", username);
                result.put("password", password2);
                result.put("servercode", serverid);

                try {
                    userInfo = srvUserService.getLoginUser(result);

                    if (MapUtils.isEmpty(userInfo)) {
                        errorMsg = "账号不存在或密码错误";
                    }else{
                        String flag = MapUtils.getString(userInfo, "flag");
                        if (flag.equals("0")) {
                            errorMsg = "账号已被禁用!";
                        } else {
                            session.setAttribute("userInfo", userInfo);
                        }
                    }


                } catch (ServiceException e) {
                    errorMsg = "系统异常！";
                }
            }
        }

        if (StringUtils.isNotEmpty(errorMsg)) {
            return getErrorResult(errorMsg);
        }

        return getSuccessResult(userInfo);
    }

    @RequestMapping("/loginout")
    public void loginout(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession();
        Object userInfo = session.getAttribute("userInfo");
        if(null != userInfo){
            session.setAttribute("userInfo" ,null);
            response.sendRedirect(request.getSession().getServletContext().getInitParameter("loginUrl"));
        }
    }


    public Map<String, Object> getErrorResult(String errorMsg) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("success", "0");
        result.put("errorMsg", errorMsg);
        return result;
    }

    public Map<String, Object> getSuccessResult(Map<String, Object> data) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("success", "1");
        result.put("data", data);
        return result;
    }

    public void setEnvironment(Environment environment) {
        this.environment = environment;
    }
}
