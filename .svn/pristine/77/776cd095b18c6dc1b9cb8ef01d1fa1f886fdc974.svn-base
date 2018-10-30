package com.wgb.freemarker.service;

import com.wgb.service.admin.AdminUserService;
import net.sf.json.JSONObject;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.http.HttpServletRequest;
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
        return getNormalUserJsonData(request.getRemoteUser(), params);
    }

    public String getNormalUserJsonData(String username, Map<String, Object> params) {
        if (username != null && !username.isEmpty()) {
            Map<String, Object> userInfo = null;
            try {
                StringBuffer sb = new StringBuffer();
                sb.append("admin_user_").append(username);
                WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
                AdminUserService adminUserService = (AdminUserService) wac.getBean("adminUserServiceImpl");
                userInfo = adminUserService.getRemoteUserInfo(username);
            } catch (RuntimeException ex) {
                this.logger.info("getNormalUserJsonData:redis读取异常" + ex.getMessage());
            }

            JSONObject jsonData = new JSONObject();
            jsonData.put("id", MapUtils.getString(userInfo, "id", ""));
            jsonData.put("fullname", MapUtils.getString(userInfo, "fullname", ""));
            jsonData.put("name", MapUtils.getString(userInfo, "name", ""));
            jsonData.put("shopcode", MapUtils.getString(userInfo, "shopcode", ""));
            jsonData.put("branchname", MapUtils.getString(userInfo, "branchname", ""));
            jsonData.put("branchcode", MapUtils.getString(userInfo, "branchcode", ""));
            jsonData.put("shopname", MapUtils.getString(userInfo, "shopname", ""));
            jsonData.put("headpic", MapUtils.getString(userInfo, "headpic", ""));
            if (jsonData != null) {
                return jsonData.toString();
            }
            return null;
        } else {
            return null;
        }
    }
}
