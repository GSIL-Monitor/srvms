package com.wgb.freemarker.service;

import com.wgb.service.srv.SrvUserService;
import net.sf.json.JSONObject;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * Created by wgb on 2017/2/4.
 */
public class UserDataServiceImpl implements UserDataService {

    private static UserDataServiceImpl userDataServiceImpl = new UserDataServiceImpl();
    private Logger logger = LoggerFactory.getLogger(UserDataServiceImpl.class);

    public static UserDataServiceImpl getInstance() {
        return userDataServiceImpl;
    }

    private UserDataServiceImpl() {
    }

    public String getUserJsonData(HttpServletRequest request, Map<String, Object> params) {
        HttpSession session = request.getSession();
        Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userInfo");
        String username = MapUtils.getString(userInfo, "account");
        return getNormalUserJsonData(username, params);
    }

    public String getNormalUserJsonData(String username, Map<String, Object> params) {
        if (username != null && !username.isEmpty()) {
            Map<String, Object> userInfo = null;

            try {
                StringBuffer sb = new StringBuffer();
                sb.append("srv_user_").append(username);
                WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
                SrvUserService srvUserService = (SrvUserService) wac.getBean("srvUserServiceImpl");
                userInfo = srvUserService.getCurUserInfo(username);

            } catch (RuntimeException ex) {
                this.logger.info("getNormalUserJsonData:读取异常" + ex.getMessage());
            }

            JSONObject jsonData = new JSONObject();
            jsonData.put("id", MapUtils.getString(userInfo, "id", ""));
            jsonData.put("account", MapUtils.getString(userInfo, "account", ""));
            jsonData.put("servercode", MapUtils.getString(userInfo, "servercode", ""));
            jsonData.put("servername", MapUtils.getString(userInfo, "servername", ""));
            jsonData.put("fullname", MapUtils.getString(userInfo, "fullname", ""));
            if (jsonData != null) {
                return jsonData.toString();
            }
            return null;
        } else {
            return null;
        }
    }
}