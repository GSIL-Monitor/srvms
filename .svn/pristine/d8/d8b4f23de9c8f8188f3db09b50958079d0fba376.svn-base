package com.wgb.service.impl.mq;

import com.wgb.service.MQMessageService;
import com.wgb.util.MqImportException;
import com.wgb.util.RscUtil;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

/**
 * Created by Administrator on 2017/1/14.
 */
public class MQImportThread implements Runnable {

    /**
     * 类路径名
     */
    private static final String CLASSNAME = MQImportThread.class.getName();

    /**
     * 日志工具
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(MQImportThread.class);

    /**
     * 报文主键id
     */
    private long id;

    /**
     * jobBeanId
     */
    private String beanId;

    /**
     * esb报文处理service
     */
    private MQMessageService mqMessageService;

    /**
     * 线程入口run方法
     */
    public void run() {
        runMessage();
    }

    /**
     *
     * 功能描述: <br>
     * 〈报文主键id赋值〉
     *
     * @param id
     * @see [相关类/方法](可选)
     * @since [产品/模块版本](可选)
     */
    public void setId(long id) {
        this.id = id;
    }

    /**
     *
     * 功能描述: <br>
     * 〈监听jobBeanId赋值〉
     *
     * @param beanId
     * @see [相关类/方法](可选)
     * @since [产品/模块版本](可选)
     */
    public void setBeanId(String beanId) {
        this.beanId = beanId;
    }

    /**
     *
     * 功能描述: <br>
     * 〈报文处理类赋值〉
     *
     * @param mqMessageService
     * @see [相关类/方法](可选)
     * @since [产品/模块版本](可选)
     */
    public void setMqMessageService(MQMessageService mqMessageService) {
        this.mqMessageService = mqMessageService;
    }

    /**
     *
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @see [相关类/方法](可选)
     * @since [产品/模块版本](可选)
     */
    private void runMessage() {
        try {
            // 根据id和类型查询报文数据
            Map<String, Object> messageMap = mqMessageService.selectMQMessageById(id);
            // 获取报文字符串数据
            String message = MapUtils.getString(messageMap, "message", "");
            // 报文内容判空
            if ("".equals(message)) {
                // 根据id更新报文表数据状态及错误信息
                mqMessageService.updateMQMessageById(id, 2, "message is empty");
                return;
            }
            // 去除换行、回车、tab符
            message = message.replace("\r", "").replace("\n", "").replace("\t", "");
            // 解析报文字符串为Map
            Map<String, Object> _messageMap = RscUtil.getMbfBody(message);
            _messageMap.putAll(messageMap);

            // 根据beanId分发业务模块处理
            mqMessageService.chooseBusinessService(beanId, _messageMap);

            // 根据id删除报文表数据
            mqMessageService.deleteMQMessageById(id);

        } catch (MqImportException e) {
            try {
                // 根据id更新报文表数据状态及错误信息
                mqMessageService.updateMQMessageById(id, 2, 1, e.getMessage());
            } catch (RuntimeException re) {
                LOGGER.error(CLASSNAME + ".runMessage() updateMQMessageById RuntimeException:" + re.getMessage()
                        + "\n id =" + id);
            }
        } catch (RuntimeException e) {
            try {
                // 根据id更新报文表数据状态及错误信息
                mqMessageService.updateMQMessageById(id, 2, e.getMessage());
            } catch (RuntimeException re) {
                LOGGER.error(CLASSNAME + ".runMessage() updateMQMessageById RuntimeException:" + re.getMessage()
                        + "\n id =" + id);
            }
        }
    }
}
