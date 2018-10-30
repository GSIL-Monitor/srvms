package com.wgb.interceptor;

import com.wgb.service.admin.AdminUserService;
import com.wgb.util.CommonUtil;
import com.wgb.util.ParamsUtil;
import com.wgb.exception.ServiceException;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AuthInterceptor extends HandlerInterceptorAdapter {

    protected final Logger logger = LoggerFactory.getLogger(getClass());

    public static final String[] whites = {
            "/entry/"};

    @Autowired
    private AdminUserService adminUserService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
        String uri = request.getRequestURI();
        String userIp = CommonUtil.getRemortIP(request);
        logger.info("客户端IP：" + userIp + "，访问链接：" + uri + "，请求参数：" + ParamsUtil.handleServletParameter(request));

        if (!isNeedCheckLogin(uri)) {
            return true;
        }

        String account = request.getRemoteUser();
        if (StringUtils.isEmpty(account)) {
            throw new ServiceException(ServiceException.SESSION_TIME_OUT);
        }

        Map<String, Object> userInfo = adminUserService.getRemoteUserInfo(account);
        if (MapUtils.isEmpty(userInfo)) {
            throw new ServiceException(ServiceException.SESSION_TIME_OUT);
        }
        return true;
    }

    /**
     * @param uri
     * @return
     */
    private boolean isNeedCheckLogin(String uri) {
        if (whites == null || whites.length == 0) {
            return true;
        }
        for (String white : whites) {
            if (uri.indexOf(white) != -1) {
                return false;
            }
        }
        return true;
    }
}