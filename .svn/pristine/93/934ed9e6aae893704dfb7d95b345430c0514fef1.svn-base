package com.wgb.controller.shop;

import com.wgb.bean.ZLResult;
import com.wgb.cache.RedisFactory;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.sms.web.ApiSmsService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.srv.SrvAssociationShopService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import com.wgb.util.Validator;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yjw on 2017/11/8.
 */
@Controller
@RequestMapping("/srv/shop")
public class SrvAssociationShopController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(SrvAssociationShopController.class);

    @Autowired
    private SrvAssociationShopService srvAssociationShopService;

    /*
     *获取关联商户数据
     */
    @RequestMapping("/getShopInfo")
    @ResponseBody
    public ZLResult getShopInfo(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        String shopcode = MapUtils.getString(params, "shopcode", "");
        String dutypersonnum = MapUtils.getString(params, "dutypersonnum", "");
        if (StringUtils.isEmpty(shopcode) && StringUtils.isEmpty(dutypersonnum)) {
            return ZLResult.Error("请输入正确的商户ID或商户联系人手机号！");
        }
        try {
            Map<String, Object> data =  srvAssociationShopService.getShopInfo(params);
            result.setData(data);
        }catch (BusinessException ex){
            LOGGER.error("查询服务商商户关联名单业务异常!" ,ex);
        }catch (Exception ex){
            LOGGER.error("查询服务商商户关联名单系统异常!" ,ex);
        }
        return result;
    }

    @RequestMapping("/associationShop/sendYzm")
    @ResponseBody
    public ZLResult sendYzm(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        String shopcode = MapUtils.getString(params, "shopcode");
        if (StringUtils.isEmpty(shopcode)) {
            result = ZLResult.Error("商户ID必须输入");
        }
        try {
            String message = srvAssociationShopService.sendYzm(params);
            if (StringUtils.isNotBlank(message)){
                result = ZLResult.Error(message);
            }
        }catch (BusinessException ex){
            LOGGER.error("关联商户发送验证码业务异常!" ,ex);
        }catch (Exception ex){
            LOGGER.error("关联商户发送验证码系统异常!" ,ex);
        }
        return result;
    }

    /*
     *关联商户
     */
    @RequestMapping("/addAssociationInfo")
    @ResponseBody
    public ZLResult addAssociationInfo(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            String message = srvAssociationShopService.addAssociationInfo(params);
            if (StringUtils.isNotBlank(message)){
                result = ZLResult.Error(message);
            }
        }catch (BusinessException ex){
            LOGGER.error("关联商户发送验证码业务异常!" ,ex);
        }catch (Exception ex){
            LOGGER.error("关联商户发送验证码系统异常!" ,ex);
        }
        return result;
    }



    /*
     *跳转关联商户页面
     */
    @RequestMapping("/association/manage/detail")
    public String association_manage_detail(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        Page<?> pageInfo = srvAssociationShopService.queryPageInfo(params);
        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "association/association_manage_detail";
    }

}