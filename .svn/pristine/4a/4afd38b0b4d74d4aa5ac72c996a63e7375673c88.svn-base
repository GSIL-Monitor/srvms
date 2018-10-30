package com.wgb.mq.send;

import com.wgb.rocketmq.SendAware;
import com.wgb.rocketmq.annotation.MQMethod;
import com.wgb.rocketmq.annotation.MQService;

/**
 * Created by wgb on 2017/10/16 0016.
 */
@MQService(topic = "topic_srvms", serviceName = "regShopInitSend")
public interface RegShopInitSend extends SendAware {

    @MQMethod(reqMbfBodyNode = true)
    void send(String message);
}
