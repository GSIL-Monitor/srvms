package com.wgb.controller.reg;

import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.aftersale.AfterSaleService;

import com.wgb.service.srv.SrvService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import com.wgb.util.Validator;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yjw on 2017/11/8
 */
@Controller
@RequestMapping("/srv")
public class SrvRegController extends BaseController {

    @Autowired
    private SrvService srvService;

    @Autowired
    private SrvUserService srvUserService;

    @Autowired
    private AfterSaleService afterSaleService;

    /*
     *跳转服务商页面
     */
    @RequestMapping("/manage")
    public String regshop(HttpServletRequest request) {
        return "srv/srv_manage";
    }

    /*
     *跳转服务商详情页
     *
     */
    @RequestMapping("/manage/detail")
    public String regshop_detail(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        //获取注册服务商数据
        Page<Map<String, Object>> pageInfo = (Page<Map<String, Object>>) srvService.querySrvPageList(params);

        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "srv/srv_manage_detail";
    }


    /*
     *跳转到注册服务商页面
     */
    @RequestMapping("/toReg")
    public String reg(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        List<Map<String, Object>> salers = afterSaleService.queryAfterSaleListLimit(params);
        request.setAttribute("salers", salers);
        return "srv/reg_srv";
    }

    /*
     *注册服务商
     */
    @RequestMapping("/addReg")
    @ResponseBody
    public Map addReg(HttpServletRequest request) {
        Map<String, Object> params = getParams();

        int count = srvUserService.checkSrvTel(params);
        if (count > 0) {
            throw new ServiceException("手机号已注册!");
        }
        srvService.addRegSrv(params);
        request.setAttribute("servercode", MapUtils.getString(params, "servercode"));
        request.setAttribute("password", MapUtils.getString(params, "password"));
        return params;
    }

    /*
     *重置密码
     */
    @RequestMapping("/updatePassword")
    @ResponseBody
    public String updatePassword(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        params.put("password" ,"123456");
        srvUserService.updatePassword(params);
        return "";
    }

    /*
     *禁用服务商
     */
    @RequestMapping("/updateFlag")
    @ResponseBody
    public String updateFlag(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        //更新服务商用户表
        srvUserService.updateSrvUser(params);
        return "";
    }

    /*
       *跳转修改页面
       */
    @RequestMapping("/toUpdate")
    public String toUpdate(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        //查询售后人员详细信息
        Map<String, Object> data = srvService.querySrvDetails(params);
        List<Map<String, Object>> salers = afterSaleService.queryAfterSaleListLimit(params);
        request.setAttribute("salers", salers);
        request.setAttribute("data", data);
        return "srv/srv_update";
    }

    /*
     *修改
     */
    @RequestMapping("/updateSrv")
    @ResponseBody
    public String updateAfterSale(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        String servercode = MapUtils.getString(params, "servercode");
        if (StringUtils.isEmpty(servercode)) {
            throw new ServiceException("参数servercode缺失!");
        }
        int count = srvUserService.checkSrvTel(params);
        if (count > 0) {
            throw new ServiceException("手机号已注册!");
        }
        //更新服务商列表
        srvService.updateSrv(params);
        //更新服务商用户表
        srvUserService.updateSrvUser(params);

        return "";
    }

}
