package com.wgb.controller;

import com.wgb.bean.ZLResult;
import com.wgb.dao.Page;
import com.wgb.exception.BusinessException;
import com.wgb.service.SrvMessageService;
import com.wgb.util.Contants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by yjw on 2017/11/8.
 */
@Controller
@RequestMapping("/message")
public class MessageController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(MessageController.class);

    @Autowired
    private SrvMessageService srvMessageService;

    @RequestMapping("/queryMessageDetail")
    @ResponseBody
    public ZLResult queryMessageDetail(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String ,Object> message = srvMessageService.queryMessageDetail(params);
            result.setData(message);
        }catch (BusinessException ex){
            LOGGER.error("查询消息详情业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询消息详情系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("/queryAdminMessageForPage")
    @ResponseBody
    public ZLResult manage(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        ZLResult result = ZLResult.Success();
        try {
            Page<?> pageInfo = srvMessageService.queryMessagePage(params);
            result.setData(pageInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询消息列表业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询消息列表系统异常!",ex);
        }
        return result;
    }
}
