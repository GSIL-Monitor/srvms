package com.wgb.service;

import java.util.List;
import java.util.Map;

/**
 * Created by wgb on 2017/2/11.
 * 缓存数据统一接口类
 */
public interface CacheDataService {

    /**
     * 获取需要缓存的Map数据
     * 如果涉及通过shopcode取数据，参数中会提供shopcode参数
     *
     * @param params
     * @return
     */
    Map<String, Object> getCacheMap(Map<String, Object> params);

    /**
     * 获取需要缓存的List数据
     * 如果涉及通过shopcode取数据，参数中会提供shopcode参数
     *
     * @param params
     * @return
     */
    List<Map<String, Object>> getCacheList(Map<String, Object> params);
}
