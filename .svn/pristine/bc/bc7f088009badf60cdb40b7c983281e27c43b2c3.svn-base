package com.wgb.controller;

import com.wgb.service.admin.AdminUserService;
import com.wgb.util.ParamsUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Controller通用父类
 */
@Controller
@Qualifier("baseController")
public abstract class BaseController {

    @Autowired
    private AdminUserService adminUserService;

    public Map<String, Object> getParams() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Map<String, Object> params = ParamsUtil.getParams(request, getUserInfo(request));

        return params;
    }

    /**
     * 获取当前登录用户信息
     *
     * @param request
     * @return
     */
    public Map<String, Object> getUserInfo(HttpServletRequest request) {
        String username = request.getRemoteUser();
        if (StringUtils.isEmpty(username)) {
            return null;
        }
        return adminUserService.getRemoteUserInfo(username);
    }
}
