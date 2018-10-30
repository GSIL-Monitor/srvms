package com.wgb.interceptor;

import com.wgb.service.srv.SrvUserService;
import com.wgb.util.CommonUtil;
import com.wgb.util.ParamsUtil;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.EnvironmentAware;
import org.springframework.core.env.Environment;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

public class AuthInterceptor extends HandlerInterceptorAdapter implements EnvironmentAware {

    protected final Logger logger = LoggerFactory.getLogger(getClass());

    public static final String[] whites = {
            "/entry/"};


    private Environment environment;

    @Autowired
    private SrvUserService srvUserService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
        String uri = request.getRequestURI();
        String userIp = CommonUtil.getRemortIP(request);
        logger.info("客户端IP：" + userIp + "，访问链接：" + uri + "，请求参数：" + ParamsUtil.handleServletParameter(request));

        if (!isNeedCheckLogin(uri)) {
            return true;
        }
        HttpSession session = request.getSession();
        Map<String,Object> userInfo = (Map<String, Object>) session.getAttribute("userInfo");

        if (MapUtils.isEmpty(userInfo)) {
            response.sendRedirect(request.getSession().getServletContext().getInitParameter("loginUrl"));
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

    @Override
    public void setEnvironment(Environment environment) {
        this.environment = environment;
    }
}