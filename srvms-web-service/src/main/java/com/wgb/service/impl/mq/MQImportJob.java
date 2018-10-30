package com.wgb.service.impl.mq;

import com.alibaba.rocketmq.common.message.MessageExt;
import com.wgb.rocketmq.MQReceiver;
import com.wgb.rocketmq.MQStartJobAware;
import com.wgb.service.MQMessageService;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanNameAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by wgb on 2017/1/13.
 */
public abstract class MQImportJob implements BeanNameAware, MQStartJobAware,MQReceiver {

    /**
     * 日志工具
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(MQImportJob.class);

    /**
     * 双字节字符数据库占位长度
     */
    private static final int DOUBLEBYTELENGTH = 3;

    /**
     * 消息最大长度
     */
    private static final int MESSAGEMAXLENGTH = 5242880;

    /**
     * 打印日志报文长度
     */
    private static final int MESSAGELOGLENGTH = 1000;

    /**
     * 类路径名
     */
    private static final String CLASSNAME = MQImportJob.class.getName();

    /**
     * 业务监听job的bean ID
     */
    private String beanId;

    public void setBeanName(String name) {
        this.beanId = name;
    }

    @Autowired
    private MQMessageService mqMessageService;

    @Autowired
    @Qualifier("mqTaskExecutor")
    private ThreadPoolTaskExecutor mqTaskExecutor;

    private long saveMQMessage(String beanId, String message, String topic, String serviceName) {
        try {
            // 保存报文数据至报文表
            long id = mqMessageService.insertMQMessage(beanId, message, topic, serviceName);
            return id;
        } catch (RuntimeException e) {
            // 判断是否报文内容超过最大长度
            if (isMessageOverMaxLength(message)) {
                LOGGER.error(CLASSNAME + ".saveMQMessage() message is over max length: \n part of message is: \n"
                        + message.substring(0, MESSAGELOGLENGTH));
                throw e;
            } else {
                LOGGER.error(CLASSNAME + ".saveMQMessage() RuntimeException:" + e.getMessage());
                throw e;
            }
        }
    }

    public void onMessage(MessageExt messageExt) {
        String topic = messageExt.getTopic();
        String serviceName = messageExt.getTags();
        String message = new String(messageExt.getBody());

        // 保存报文数据
        long id = saveMQMessage(beanId, message, topic, serviceName);

        // 解析处理报文数据
        parseMQMessage(id, beanId);
    }

    private void parseMQMessage(long id, String beanId) {

        if (StringUtils.isEmpty(beanId)) {
            mqMessageService.updateMQMessageById(id, 1, "beanId is empty");
            return;
        }

        try {
            // 实例化报文处理线程类
            MQImportThread mqImportThread = new MQImportThread();
            // id赋值
            mqImportThread.setId(id);
            // jobBeanId赋值
            mqImportThread.setBeanId(beanId);
            // 报文处理类赋值
            mqImportThread.setMqMessageService(mqMessageService);

            // 执行线程，解析处理报文
            mqTaskExecutor.execute(mqImportThread);
        } catch (RuntimeException e) {
            // 获取异常消息
            String exceptionmessage = e.getMessage();
            // 记录异常日志
            LOGGER.error(CLASSNAME + ".parseMQMessage() RuntimeException:" + exceptionmessage + "\n id = " + id);
            try {
                // 根据id更新报文表数据状态和异常消息
                mqMessageService.updateMQMessageById(id, 1, exceptionmessage);
            } catch (RuntimeException re) {
                LOGGER.error(CLASSNAME + ".parseMQMessage() updateMQMessageById RuntimeException:" + re.getMessage()
                        + "\n id = " + id);
            }
        }
    }

    /**
     * 功能描述: <br>
     * 〈消息最大长度校验〉
     *
     * @param message
     * @return
     * @see [相关类/方法](可选)
     * @since [产品/模块版本](可选)
     */
    private boolean isMessageOverMaxLength(String message) {
        // 参数判空
        if (StringUtils.isEmpty(message)) {
            return false;
        }

        // 双字节字符正则表达式
        String regEx = "[^\\x00-\\xff]";
        Pattern p = Pattern.compile(regEx);
        Matcher m = p.matcher(message);

        // 统计双字节字符个数
        int doubleByteCount = 0;
        while (m.find()) {
            doubleByteCount++;
        }

        // 比较字符串与数据库字段长度(双字节字符*3)
        if ((doubleByteCount * DOUBLEBYTELENGTH + (message.length() - doubleByteCount)) > MESSAGEMAXLENGTH) {
            return true;
        }

        return false;
    }
}
