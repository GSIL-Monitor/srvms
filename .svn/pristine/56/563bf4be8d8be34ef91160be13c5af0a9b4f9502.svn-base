package com.wgb.util;

/**
 * Created by Administrator on 2017/5/23 0023.
 */
public class SystemConfig {

    public static String WX_TOKEN;

    private static PropConfig propConfig;

    static {
        propConfig = PropConfig.loadConfig("setting-web.properties");

        if (propConfig != null) {
            WX_TOKEN = propConfig.getConfigString("wx.token");
        }
    }
}
