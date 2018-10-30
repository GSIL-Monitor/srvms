package com.wgb.controller;

import com.wgb.service.UserLoginService;
import com.wgb.util.MD5Util;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by pc on 2018/10/30.
 */
@Controller
@RequestMapping("/user")
public class UserLoginController extends BaseController {


    @Autowired
    private UserLoginService userLoginService;

    @RequestMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response) {

        Map<String, Object> params = getParams();

        Map<String, Object> userInfo =userLoginService.login(params);

        System.out.println("一切正常！！" + params);

        return null;

    }

}
