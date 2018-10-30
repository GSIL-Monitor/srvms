package com.wgb.freemarker.service;

import com.wgb.service.admin.AdminMenuService;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by wgb on 2017/1/24.
 */
public class MenuDataServiceImpl implements MenuDataService {

    private static MenuDataServiceImpl menuDataServiceImpl = new MenuDataServiceImpl();
    private Logger logger = LoggerFactory.getLogger(MenuDataServiceImpl.class);

    public static MenuDataServiceImpl getInstance() {
        return menuDataServiceImpl;
    }

    private MenuDataServiceImpl() {
    }

    public String getMenuJsonData(HttpServletRequest request, Map<String, Object> params) {
        return getNormalMenuJsonData(request.getRemoteUser(), params);
    }

    public String getNormalMenuJsonData(String account, Map<String, Object> params) {
        if (account != null && !account.isEmpty()) {
            List<Map<String, Object>> menuList = null;
            try {
                StringBuffer sb = new StringBuffer();
                sb.append("admin_menu_").append(account);
                WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
                AdminMenuService adminMenuService = (AdminMenuService) wac.getBean("adminMenuServiceImpl");
                menuList = adminMenuService.getRemoteMenuList(account);
            } catch (RuntimeException ex) {
                this.logger.info("getNormalMenuJsonData:redis读取异常" + ex.getMessage());
            }
            JSONArray jsonData = JSONArray.fromObject(menuList);
            if (jsonData != null) {
                return jsonData.toString();
            }
            return null;
        } else {
            return null;
        }
    }
}
