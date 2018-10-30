package com.wgb.controller;

import com.wgb.service.MQMessageService;
import com.wgb.util.NetWorkUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by Administrator on 2017/1/14.
 */
@Controller
@RequestMapping("/mqmessage")
public class MQMessageController extends BaseController {

    /**
     * 日志工具类
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(MQMessageController.class);

    /**
     * 类名
     */
    private static final String CLASSNAME = MQMessageController.class.getName();

    @Autowired
    private MQMessageService mqMessageService;

    @RequestMapping("/xmlQuery")
    public String xmlQuery(HttpServletRequest request) {
        // 获取选择参数
        Map<String, Object> params = getParams();
        request.setAttribute("pageInfo", mqMessageService.selectXmlMessage(params));
        return "system/xmlmessagequery";
    }

    @RequestMapping("/deleteXmlQuery")
    @ResponseBody
    public String deleteXmlQuery(HttpServletRequest request) {
        try {
            // 获取参数
            Map<String, Object> params = getParams();
            params.put("operateip", NetWorkUtil.getRemortIP(request));
            return mqMessageService.deleteXmlQuery(params);
        } catch (RuntimeException e) {
            LOGGER.error(CLASSNAME + ".deleteXmlQuery() RuntimeException:" + e.getMessage());
            return "error";
        }
    }

    @RequestMapping("/optXmlQuery")
    @ResponseBody
    public String optXmlQuery(HttpServletRequest request) {
        try {
            // 获取选择参数
            Map<String, Object> params = getParams();
            // 客户端IP处理
            params.put("operateip", NetWorkUtil.getRemortIP(request));
            return mqMessageService.optXmlMessage(params);
        } catch (RuntimeException e) {
            LOGGER.error(CLASSNAME + ".optXmlQuery() RuntimeException:" + e.getMessage());
            return "error";
        }
    }
}
