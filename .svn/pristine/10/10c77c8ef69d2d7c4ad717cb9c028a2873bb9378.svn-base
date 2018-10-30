package com.wgb.controller.admin;

import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.admin.AdminFeedbackService;
import com.wgb.util.Contants;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by wgb on 2017/3/3.
 */
@Controller
@RequestMapping("/admin/feedback")
public class AdminFeedbackController extends BaseController {

    @Autowired
    private AdminFeedbackService adminFeedbackService;

    @RequestMapping("/manage")
    public String manage(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        Page<?> pageInfo = adminFeedbackService.queryPageList(params);
        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "admin/feedback_manage";
    }

    @RequestMapping("/feedbackToView")
    public String purchaseOrderToView(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        String id = MapUtils.getString(params, "id");
        if (StringUtils.isEmpty(id)) {
            throw new ServiceException(ServiceException.OPER_ERROR);
        }
        Map<String, Object> feedback = adminFeedbackService.getFeedbackInfo(params);
        request.setAttribute("feedback", feedback);
        return "admin/feedback_view";
    }

    @RequestMapping("/delDomain")
    @ResponseBody
    public String delDomain(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        String id = MapUtils.getString(params, "id", "");
        if (StringUtils.isNotEmpty(id)) {
            adminFeedbackService.delDomain(params);
        } else {
            throw new ServiceException("操作异常！");
        }
        return "";
    }
}
