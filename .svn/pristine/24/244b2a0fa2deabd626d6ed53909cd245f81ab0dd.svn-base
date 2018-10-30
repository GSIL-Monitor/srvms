package com.wgb.controller.shop;

import com.wgb.controller.BaseController;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.urms.admin.ApiBranchService;
import com.wgb.util.Contants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by yjw on 2017/11/8.
 */
@Controller
@RequestMapping("/srv/shop")
public class SrvShopBranchExpireController extends BaseController {

    @Autowired
    private ApiBranchService apiBranchService;

    /*
     *跳转到商户门店将要到期页面
     */
    @RequestMapping("/willExpireBranchList")
    public String willExpireBranchList(HttpServletRequest request) {
        return "shop/will_expire_branch";
    }

    /*
     *跳转到商户门店将要到期页面
     */
    @RequestMapping("/willExpireBranchListDetail")
    public String willExpireBranchListDetail(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        ZLRpcResult rpcResult = apiBranchService.queryWillExpirePageList(params);
        request.setAttribute(Contants.PAGE_INFO, rpcResult.getData());
        return "shop/will_expire_branch_detail";
    }

    /**
     * 跳转到商户门店已经到期页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/alreadyExpireBranchList")
    public String alreadyExpireBranchList(HttpServletRequest request) {
        return "shop/already_expire_branch";
    }

    /**
     * 跳转到商户门店已经到期页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/alreadyExpireBranchListDetail")
    public String alreadyExpireBranchListDetail(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        ZLRpcResult rpcResult = apiBranchService.queryAlreadyExpirePageList(params);
        request.setAttribute(Contants.PAGE_INFO, rpcResult.getData());
        return "shop/already_expire_branch_detail";
    }

}
