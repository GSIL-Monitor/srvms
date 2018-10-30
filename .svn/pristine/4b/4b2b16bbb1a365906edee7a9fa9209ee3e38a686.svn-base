package com.wgb.service;

import com.wgb.dao.Page;

import java.util.Map;

/**
 * Created by Administrator on 2017/1/13.
 */
public interface MQMessageService {

    /**
     * 插入消息队列信息
     * @param beanId
     * @param message
     * @param topic
     * @param serviceName
     * @return
     */
    long insertMQMessage(String beanId, String message, String topic, String serviceName);

    /**
     * 更新消息队列信息通过id
     * @param id
     * @param checkstatus
     * @param errorreason
     * @return
     */
    int updateMQMessageById(long id, int checkstatus, String errorreason);

    /**
     * 查询信息
     * @param id
     * @return
     */
    Map<String, Object> selectMQMessageById(long id);

    /**
     *  选择商业服务
     * @param beanId
     * @param messageMap
     */
    void chooseBusinessService(String beanId, Map<String, Object> messageMap);

    /**
     * 删除消息通过id
     * @param id
     * @return
     */
    int deleteMQMessageById(long id);

    /**
     * 更新消息队列信息通过id
     * @param id
     * @param checkstatus
     * @param isrepeat
     * @param errorreason
     * @return
     */
    int updateMQMessageById(long id, int checkstatus, int isrepeat, String errorreason);

    /**
     * 查询xml消息
     * @param params
     * @return
     */
    Page<?> selectXmlMessage(Map<String, Object> params);

    /**
     * 删除xml查询
     * @param params
     * @return
     */
    String deleteXmlQuery(Map<String, Object> params);

    /**
     * 选择xml消息
     * @param params
     * @return
     */
    String optXmlMessage(Map<String, Object> params);
}
