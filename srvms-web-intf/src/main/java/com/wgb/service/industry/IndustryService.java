package com.wgb.service.industry;

import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-30 16:29
 **/
public interface IndustryService {

    /**
     * 获得行业名称列表
     * @param params
     * @return
     */
    List<Map<String, Object>> getIndustryList(Map<String, Object> params);
}
