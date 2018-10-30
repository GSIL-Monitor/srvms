package com.wgb.controller.changepwd;

import com.wgb.controller.BaseController;
import com.wgb.service.changepwd.ChangePwdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("/changepwd")
public class ChangePwdController extends BaseController {

    @Autowired
    private ChangePwdService changePwdService;

    @RequestMapping("/manage")
    public String manage(HttpServletRequest request) {
        return "changepwd/changepwd_manage";
    }

    @RequestMapping("/changePassword")
    @ResponseBody
    public String changePwd(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        return changePwdService.changePwd(params);
    }
}
