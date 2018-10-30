package com.wgb.controller.getpwd;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.exception.ServiceException;
import com.wgb.service.CacheService;
import com.wgb.service.dubbo.sms.web.ApiSmsService;
import com.wgb.service.pwd.GetPwdService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import com.wgb.util.Validator;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wgb on 2017/2/14.
 */
@Controller
@RequestMapping("/getpwd")
public class GetPwdController extends BaseController {

    @Autowired
    private GetPwdService getPwdService;


    @RequestMapping("/entry/sendYzm")
    @ResponseBody
    public ZLResult sendYzm(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        String account = MapUtils.getString(params, "account");
        if (StringUtils.isEmpty(account)) {
            return ZLResult.Error("账号输入为空");
        }
        String message = getPwdService.sendYzm(params);
        if (StringUtils.isNotBlank(message)){
            result = ZLResult.Error(message);
        }
        return result;
    }

    @RequestMapping("/entry/checkYzm")
    @ResponseBody
    public ZLResult checkYzm(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        ZLResult result = ZLResult.Success();
        String account = MapUtils.getString(params, "account");
        String yzm = MapUtils.getString(params, "yzm");
        if (StringUtils.isEmpty(account) || StringUtils.isEmpty(yzm)) {
            return ZLResult.Error("参数缺失");
        }
        String message = getPwdService.checkYzm(params);
        if (StringUtils.isNotBlank(message)){
            result = ZLResult.Error(message);
        }
        return result;
    }

    @RequestMapping("/entry/updatePassword")
    @ResponseBody
    public ZLResult updatePassword(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        String account = MapUtils.getString(params, "account");
        String yzm = MapUtils.getString(params, "yzm");
        String password = MapUtils.getString(params, "password");
        if (StringUtils.isEmpty(account) || StringUtils.isEmpty(yzm) || StringUtils.isEmpty(password)) {
            return ZLResult.Error("缺失参数");
        }
       String message =  getPwdService.updatePassword(params);
        if (StringUtils.isNotBlank(message)){
            result = ZLResult.Error(message);
        }
        return result;
    }

    @RequestMapping("/entry/checkAccount")
    @ResponseBody
    public ZLResult checkAccount(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        String account = MapUtils.getString(params, "account");
        if (StringUtils.isEmpty(account)) {
            return ZLResult.Error("缺失参数!");
        }
        String message = getPwdService.checkAccount(params);
        if (StringUtils.isNotBlank(message)){
            result = ZLResult.Error(message);
        }
        return result;
    }
}
