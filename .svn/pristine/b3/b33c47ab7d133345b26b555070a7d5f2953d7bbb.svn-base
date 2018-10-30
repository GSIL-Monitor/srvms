package com.wgb.controller.message;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.service.message.AdminMessageService;
import com.wgb.util.Contants;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 服务商消息管理
 *
 * @author fxs
 * @create 2018-05-21 15:39
 **/
@Controller
@RequestMapping("adminMesssage")
public class AdminMessageController extends BaseController{

    @Autowired
    private AdminMessageService adminMessageService;

    private static final Logger LOGGER = LoggerFactory.getLogger(AdminMessageController.class);


    @RequestMapping("demo")
    public String demo(){
        return "index";
    }

    /**
     * 跳转页面
     * @return
     */
    @RequestMapping("toAdminMessage")
    public String toAdminMessage(){
        return "srv/system_message";
    }

    /**
     * 跳转页面
     * @return
     */
    @RequestMapping("toAdminMessageAdd")
    public String toAdminMessageAdd(){
        return "srv/system_message_add";
    }

    /**
     * 查询列表
     * @return
     */
    @RequestMapping("queryAdminMessage")
    public String queryAdminMessage(HttpServletRequest request){
        Map<String, Object> params = getParams();
        Page<?> result = adminMessageService.queryAdminMessage(params);
        request.setAttribute(Contants.PAGE_INFO ,result);
        return "srv/system_message_table";
    }


    /**
     * 发送消息
     * @param request
     * @return
     */
    @RequestMapping("sendMessage")
    @ResponseBody
    public String sendMessage(HttpServletRequest request){
        Map<String, Object> params = getParams();
        return adminMessageService.updateMessageStatusById(params);
    }


    /**
     * 删除消息
     * @param request
     * @return
     */
    @RequestMapping("delMessage")
    @ResponseBody
    public String delMessage(HttpServletRequest request){
        Map<String, Object> params = getParams();
        return adminMessageService.deleteMessageById(params);
    }


    /**
     * 新增或修改
     * @param request
     * @return
     */
    @RequestMapping("saveOrUpdate")
    @ResponseBody
    public ZLResult saveOrUpdate(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            String id = MapUtils.getString(params, "id");
            String message;
            if(StringUtils.isNotBlank(id)){
                message = adminMessageService.updateMessageById(params);
            }else {
                message = adminMessageService.saveMessage(params);
            }
            result.setData("保存成功");
        } catch (Exception e) {
            LOGGER.error("保存更新消息失败!" ,e);
            result.setData("保存失败，请联系管理员！");
        }
        return result;
    }


    /**
     * 跳转修改页面
     */
    @RequestMapping("toUpdateMessage")
    public String toUpdateMessage(HttpServletRequest request){
        Map<String, Object> params = getParams();
        Map<String ,Object> result = adminMessageService.queryMessageDetail(params);
        request.setAttribute("message" ,result);
        return "srv/system_message_add";
    }

    /**
     * 跳转修改页面
     */
    @RequestMapping("queryMessageDetail")
    public String queryMessageDetail(HttpServletRequest request){
        Map<String, Object> params = getParams();
        Map<String ,Object> result = adminMessageService.queryMessageDetail(params);
        request.setAttribute("message" ,result);
        return "srv/system_message_detail";
    }



}
