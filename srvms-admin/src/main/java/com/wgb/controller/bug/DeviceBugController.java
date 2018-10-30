package com.wgb.controller.bug;

import com.wgb.controller.BaseController;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.bugms.admin.ApiDeviceBugService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by yjw on 2018/3/18.
 */
@Controller
@RequestMapping("/device/bug")
public class DeviceBugController extends BaseController {

    @Autowired
    private ApiDeviceBugService apiDeviceBugService;

    @RequestMapping("/getDeviceBugInfo")
    @ResponseBody
    public Map<String, Object> getDeviceBugInfo(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        ZLRpcResult result = apiDeviceBugService.getDeviceBugInfo(params);
        return result.getMap();
    }
}
