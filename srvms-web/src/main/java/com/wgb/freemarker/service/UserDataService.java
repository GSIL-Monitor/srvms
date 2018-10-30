package com.wgb.freemarker.service;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by wgb on 2017/2/4.
 */
public interface UserDataService {
    String getUserJsonData(HttpServletRequest request, Map<String, Object> params);
}
