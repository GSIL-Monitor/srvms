package com.wgb.service.srv;

import com.wgb.dao.Page;

import java.util.List;
import java.util.Map;

public interface SrvShopService {

    Map<String,Object> getShopCountMap(String servercode);

    Map<String,Object> getAssociationSrv(Map<String, Object> params);

    void addSrvShop(Map<String, Object> params);

    Map<String,Object> getServercode(Map<String, Object> params);

    Map<String,Object> getSrvShopInfo(Map<String, Object> params);

    Page<?> findSrvShopForPage(Map<String, Object> params);
}
