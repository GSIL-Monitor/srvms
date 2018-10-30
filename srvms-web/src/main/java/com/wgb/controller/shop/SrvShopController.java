package com.wgb.controller.shop;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.urms.admin.ApiBranchService;
import com.wgb.service.dubbo.urms.admin.ApiRechargeOrderService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yjw on 2017/11/8.
 */
@Controller
@RequestMapping("/srv/shop")
public class SrvShopController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(SrvShopController.class);

    @Autowired
    private SrvShopService srvShopService;

    @RequestMapping("/querySrvShopPage")
    @ResponseBody
    public ZLResult querySrvShopPage(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Page<?> pageInfo =  srvShopService.querySrvShopPage(params);
            result.setData(pageInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询服务商商户信息业务异常",ex);
        }catch (Exception ex){
            LOGGER.error("查询服务商商户信息系统异常",ex);
        }
        return result;
    }

    /*
     *更新商户标注信息(可批量)
     */
    @RequestMapping("/updateShopfollow")
    @ResponseBody
    public ZLResult updateShopfollow(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            srvShopService.updateShopfollow(params);
        }catch (BusinessException ex){
            LOGGER.error("修改商户跟进状态/备注业务异常",ex);
        }catch (Exception ex){
            LOGGER.error("修改商户跟进状态/备注系统异常",ex);
        }
        return result;
    }

    @RequestMapping("/queryShopDetail")
    @ResponseBody
    public ZLResult queryShopDetail(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String, Object> shopDetail = srvShopService.queryShopDetail(params);
            result.setData(shopDetail);
        }catch (BusinessException ex){
            LOGGER.error("查询商户详情业务异常",ex);
        }catch (Exception ex){
            LOGGER.error("查询商户详情系统异常",ex);
        }
        return result;
    }

    @RequestMapping("/queryBranchList")
    @ResponseBody
    public ZLResult queryBranchList(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Page pageInfo = srvShopService.queryBranchList(params);
            result.setData(pageInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询指定商户下的门店详情业务异常",ex);
        }catch (Exception ex){
            LOGGER.error("查询指定商户下的门店系统异常",ex);
        }
        return result;
    }

    @RequestMapping("/rechargeDetail")
    @ResponseBody
    public ZLResult rechargeDetail(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            List<Map<String, Object>> detail = srvShopService.rechargeDetail(params);
            result.setData(detail);
        }catch (BusinessException ex){
            LOGGER.error("查询指定商户下的门店详情业务异常",ex);
        }catch (Exception ex){
            LOGGER.error("查询指定商户下的门店系统异常",ex);
        }
        return result;
    }
}
