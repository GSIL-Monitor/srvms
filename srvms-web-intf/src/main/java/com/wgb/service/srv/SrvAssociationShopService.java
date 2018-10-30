package com.wgb.service.srv;

import com.wgb.dao.Page;

import java.util.List;
import java.util.Map;

public interface SrvAssociationShopService {

    /**
     * 关联商户
     * @param params
     * @return
     */
    String addAssociationInfo(Map<String, Object> params);

    /**
     *
     * @param params
     * @return
     */
    Page<?> queryPageInfo(Map<String, Object> params);

    /**
     * 获取商户门店名称列表
     * @param params
     * @return
     */
    List<Map<String,Object>> getIndustryNameList(Map<String, Object> params);

    /**
     * 获取查询商户数据
     * @param params
     * @return
     */
    Map<String,Object> getShopInfo(Map<String, Object> params);

    /**
     * 发送验证码
     * @param params
     * @return
     */
    String sendYzm(Map<String, Object> params);
}
