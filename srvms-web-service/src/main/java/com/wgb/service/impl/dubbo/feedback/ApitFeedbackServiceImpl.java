package com.wgb.service.impl.dubbo.feedback;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitFeedbackService;
import com.wgb.service.feedback.FeedbackService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 13:49
 **/
@Service
public class ApitFeedbackServiceImpl implements ApitFeedbackService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitFeedbackServiceImpl.class);
    @Autowired
    private FeedbackService feedbackService;

    public ZLRpcResult saveFeedback(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        feedbackService.saveFeedback(params);
        return result;
    }

}
