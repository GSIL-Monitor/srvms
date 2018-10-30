package com.wgb.controller.feedback;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.exception.BusinessException;
import com.wgb.service.feedback.FeedbackService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("/feedback")
public class FeedbackController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(FeedbackController.class);
    @Autowired
    private FeedbackService feedbackService;

    @RequestMapping("/saveFeedback")
    @ResponseBody
    public ZLResult saveFeedback(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            feedbackService.saveFeedback(params);
        }catch (BusinessException ex){
            LOGGER.error("保存意见反馈信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("保存意见反馈信息系统异常!",ex);
        }
        return result;
    }
}
