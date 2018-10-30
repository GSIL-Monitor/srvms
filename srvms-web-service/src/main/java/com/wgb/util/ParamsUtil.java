package com.wgb.util;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class ParamsUtil {

    private static final String PAGE = "page";
    private static final String PAGESIZE = "pageSize";

    /**
     * @param request
     * @return
     */
    public static Map<String, Object> getParams(HttpServletRequest request) {
        return getParams(request, null);
    }

    /**
     * @param request
     * @return
     */
    public static Map<String, Object> getParams(HttpServletRequest request, Map<String, Object> userInfo) {
        Map<String, Object> requestParams = ParamsUtil.handleServletParameter(request);

        if (StringUtils.isEmpty(requestParams.get(PAGE) == null ? null : requestParams.get(PAGE).toString())) {
            requestParams.put(PAGE, Contants.PAGE_START);

        } else {
            requestParams.put(PAGE, MapUtils.getIntValue(requestParams, PAGE, Contants.PAGE_START));
        }
        if (StringUtils.isEmpty(requestParams.get(PAGESIZE) == null ? null : requestParams.get(PAGESIZE).toString())) {
            requestParams.put(PAGESIZE, Contants.PAGE_SIZE);
        } else {
            requestParams.put(PAGESIZE, MapUtils.getIntValue(requestParams, PAGESIZE, Contants.PAGE_SIZE));
        }

        requestParams.put(Contants.USER_IP, CommonUtil.getRemortIP(request));
        requestParams.put(Contants.LOGIN_USER_ID, MapUtils.getString(userInfo, "id"));
        requestParams.put(Contants.LOGIN_USER_FULL_NAME, MapUtils.getString(userInfo, "fullname"));
        requestParams.put(Contants.LOGIN_USER_SERVER_CODE, MapUtils.getString(userInfo, "servercode"));
        requestParams.put(Contants.LOGIN_USER_SERVER_NAME, MapUtils.getString(userInfo, "servername"));
        requestParams.put(Contants.LOGIN_USER_IS_REQUIRED, MapUtils.getString(userInfo, "required"));
        return requestParams;
    }

    /**
     * @param request
     * @return
     */
    @SuppressWarnings("unchecked")
    public static Map<String, Object> handleServletParameter(HttpServletRequest request) {
        Map<String, String[]> requestParameter = request.getParameterMap();

        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.putAll(requestParameter);

        Map<String, Object> rParams = new HashMap<String, Object>(0);
        for (Map.Entry<String, Object> m : parameter.entrySet()) {
            String key = m.getKey();
            Object[] obj = (Object[]) parameter.get(key);
            rParams.put(key, (obj.length > 1) ? obj : obj[0]);
        }
        return rParams;
    }
}
