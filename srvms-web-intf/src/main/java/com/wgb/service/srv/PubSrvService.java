package com.wgb.service.srv;

import java.util.List;
import java.util.Map;

public interface PubSrvService {
    /**
     * 查询服务商资料
     * @param params
     * @return
     */
    Map<String, Object> querySrvDetails(Map<String, Object> params);
    Map<String,Object> queryService(Map<String, Object> params);

    Map<String,Object> getServerCodeByCode(Map<String, Object> params);
}
