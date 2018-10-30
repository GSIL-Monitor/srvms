package com.wgb.controller.srv;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.exception.ServiceException;
import com.wgb.service.srv.PubSrvService;
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
@RequestMapping("/srv/information")
public class SrvInformationController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(SrvInformationController.class);

    @Autowired
    private PubSrvService pubSrvService;

    /**
     * 跳转用户管理页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/detail")
    @ResponseBody
    public ZLResult manage(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String, Object> srvDetail = pubSrvService.querySrvDetails(params);
            result.setData(srvDetail);
        }catch (ServiceException ex){
            LOGGER.error("查询服务商资料业务异常!异常代码:{},异常信息:{}",ex.getCode() ,ex.getCnMsg());
            result = ZLResult.Error(ex);
        }catch (Exception e){
            LOGGER.error("查询服务商资料系统异常!",e);
            result = ZLResult.Error(ServiceException.SYS_ERROR);
        }
        return result;
    }


}
