package com.wgb.service;

import com.wgb.dao.Page;

import java.util.List;
import java.util.Map;

public interface SrvMessageService {

    /**
     * 获取消息列表
     * @param params
     * @return
     */
    List<Map<String,Object>> queryMessageList(Map<String, Object> params);

    /**
     * 获取消息页面
     * @param params
     * @return
     */
    Page<?> queryMessagePage(Map<String, Object> params);

    /**
     * 查询bug数量
     * @param params
     * @return
     */
    int queryDeviceBugCount(Map<String, Object> params);

    /**
     * 查询消息详情
     * @param params
     * @return
     */
    Map<String,Object> queryMessageDetail(Map<String, Object> params);
}
