package com.wgb.controller.address;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.controller.getpwd.GetPwdController;
import com.wgb.service.address.ServiceAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-07-12 11:58
 **/
@Controller
@RequestMapping("seviceaddress")
public class ServiceAddressController extends BaseController{

    @Autowired
    private ServiceAddressService serviceAddressService;

    @RequestMapping("queryServiceAddress")
    @ResponseBody
    public ZLResult queryServiceAddress(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        Map<String, Object> map = serviceAddressService.queryServiceAddress(params);
        result.setData(map);
        return result;
    }
}
