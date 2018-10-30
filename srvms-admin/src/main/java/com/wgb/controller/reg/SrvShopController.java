package com.wgb.controller.reg;

import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.srv.SrvService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by yjw on 2017/11/8
 */
@Controller
@RequestMapping("/srv/shop")
public class SrvShopController extends BaseController {

    @Autowired
    private ApiShopService apiShopService;

    @Autowired
    private SrvShopService srvShopService;

    @RequestMapping("/toChoose")
    public String toChoose(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        ZLRpcResult rpcResult = apiShopService.queryAdminSrvmsShopPageList(params);
        request.setAttribute("pageInfo", rpcResult.getData());
        return "shop/shop_choose";
    }

    @RequestMapping("/list")
    public String list(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        ZLRpcResult rpcResult = apiShopService.queryAdminSrvmsShopPageList(params);
        request.setAttribute("pageInfo", rpcResult.getData());
        return "shop/shop_list";
    }

    @RequestMapping("toSrvShopManage")
    public String toSrvShopView(HttpServletRequest request){
        Map<String, Object> params = getParams();
        String servercode = MapUtils.getString(params ,"servercode");
        if (StringUtils.isBlank(servercode)){
            return "error";
        }
        request.setAttribute("servercode" ,servercode);
        return "shop/srv_shop_manage";
    }

    @RequestMapping("querySrvShopPage")
    public String querySrvShopPage(HttpServletRequest request){
        Map<String, Object> params = getParams();
        Page<?> pageInfo = srvShopService.findSrvShopForPage(params);
        request.setAttribute(Contants.PAGE_INFO , pageInfo);
        return "shop/srv_shop_list";
    }
}
