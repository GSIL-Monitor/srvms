/**
 * Copyright (C) 2017 FZJT Co. Ltd.
 *
 * @className:com.wgb.service.impl.assistant.AssistantServiceImpl
 * @description:
 * @version:v1.0.0
 * @author:CoCo Modification History:
 * Date         Author      Version     Description
 * -----------------------------------------------------------------
 * 2017年2月10日      CoCo        v1.0.0        create
 */
package com.wgb.service.impl.feedback;

import com.wgb.dao.CommonDalClient;
import com.wgb.service.feedback.FeedbackService;
import com.wgb.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class FeedbackServiceImpl extends BaseServiceImpl implements FeedbackService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.feedback.FeedbackServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Override
    public void saveFeedback(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "insertObject", params);
    }



}
