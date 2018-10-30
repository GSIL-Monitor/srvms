package com.wgb.service;

import java.util.List;
import java.util.Map;

/**
 * Created by wgb on 2016/8/23.
 */
public interface CacheService {

    /**
     * 根据key获取缓存list
     * 系统缓存：shopcode可以不传
     * 门店缓存：shopcode必传
     *
     * @param args
     * @return
     */
    List<Map<String, Object>> getCacheList(String key, String... args);

    /**
     * 根据key获取缓存map
     * 系统缓存：shopcode可以不传
     * 门店缓存：shopcode必传
     *
     * @param args
     * @return
     */
    Map<String, Object> getCacheMap(String key, String... args);

    /**
     * 更新所有不分库数据的所有缓存
     */
    void updateAllCache(String... args);

    /**
     * 根据key更新分库数据的缓存
     *
     * @param key
     * @param args
     */
    void updateCache(String key, String... args);

    /**发送验证码
     * @param yzm
     * @param mobile
     * @param type
     */
    void setYzm(String yzm, String mobile, String type);

    /**
     * 获得验证码
     * @param mobile
     * @param type
     * @return
     */
    String getYzm(String mobile, String type);
}
