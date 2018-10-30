package com.wgb.service.srv;

import com.wgb.dao.Page;

import java.util.List;
import java.util.Map;

/**
 * Created by 11609 on 2017/12/19.
 */
public interface SrvService {

    Page<?> querySrvPageList(Map<String, Object> params);

    void addRegSrv(Map<String, Object> params);

    void updateFlag(Map<String, Object> params);

    Map<String,Object> queryServer(Map<String, Object> params);
    Map<String,Object> queryService(Map<String, Object> params);


    Map<String,Object> getSrvTel(Map<String, Object> srvMap);

    Map<String,Object> querySrvDetails(Map<String, Object> params);

    void updateSrv(Map<String, Object> params);

    Map<String,Object> queryServerByServerCode(Map<String, Object> params);

    Map<String,Object> getSrvInfo(Map<String, Object> data);

    List<Map<String ,Object>> queryServerInfoByShopCode(Map<String ,Object> params);
}
