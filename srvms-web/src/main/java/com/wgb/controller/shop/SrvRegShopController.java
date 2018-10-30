package com.wgb.controller.shop;

import com.wgb.cache.RedisFactory;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.CacheService;
import com.wgb.service.dubbo.sms.web.ApiSmsService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.dubbo.urms.admin.ApiUserService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import com.wgb.util.Validator;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
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
public class SrvRegShopController extends BaseController {

    @Autowired
    private SrvShopService srvShopService;

    @Autowired
    private ApiShopService apiShopService;

    @Autowired
    private ApiUserService apiUserService;

    @Autowired
    private ApiSmsService apiSmsService;

    @Autowired
    private CacheService cacheService;

    /*
     *跳转注册商户页面
     */
    @RequestMapping("/reg/manage")
    public String regshop(HttpServletRequest request) {
        return "reg/reg_shop_manage";
    }

    /*
     *跳转服务商注册商户详情页
     */
    @RequestMapping("reg/manage/detail")
    public String regshop_detail(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        //获取服务商注册商户数据
        ZLRpcResult rpcResult = null;
        try {
            rpcResult = apiShopService.queryRegShopPageList(params);
        } catch (Exception ex) {
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        Page<Map<String, Object>> pageInfo = (Page<Map<String, Object>>) rpcResult.getData();
        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "reg/reg_shop_manage_detail";
    }

    /*
     *跳转到服务商注册商户页面
     */
    @RequestMapping("/toReg")
    public String reg(HttpServletRequest request) {
        return "reg/reg_shop";
    }

    /*
     *注册商户
     */
    @RequestMapping("/addReg")
    @ResponseBody
    public String addReg(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        params.put("account", MapUtils.getString(params, "tel"));
        //校验手机号
        ZLRpcResult rpcResult = apiUserService.checkAccount(params);

        String account = MapUtils.getString(rpcResult.getMap(), "account");
        String servercode = MapUtils.getString(rpcResult.getMap(), "servercode");
        if (StringUtils.isNotEmpty(account)) {
            if (StringUtils.isNotEmpty(servercode)) {
                throw new ServiceException("商户已关联服务商,请重新输入！");
            } else {
                return "商户已存在!";
            }
        }

        //校验验证码
        String msg = checkYzm(params);
        if (StringUtils.isNotEmpty(msg)) {
            throw new ServiceException(msg);
        }
        params.put("issrvreg", "1");
        srvShopService.addRegShop(params);
        return "";
    }

    @RequestMapping("/reg/sendYzm")
    @ResponseBody
    public String sendYzm(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        String account = MapUtils.getString(params, "account");
        if (StringUtils.isEmpty(account)) {
            return "账号必须输入";
        }

        //校验手机号
        ZLRpcResult rpcResult = apiUserService.checkAccount(params);

        String tel = MapUtils.getString(rpcResult.getMap(), "account");
        String servercode = MapUtils.getString(rpcResult.getMap(), "servercode");
        if (StringUtils.isNotEmpty(tel)) {
            if (StringUtils.isNotEmpty(servercode)) {
                throw new ServiceException("商户已关联服务商,请重新输入！");
            } else {
                return "商户已存在!";
            }
        }
        Map<String, Object> data = new HashMap<String, Object>();
        if (Validator.isMobile(account)) {
            String mobileLockKey = Contants.SMS_AAS_TYPE + account + "_lock";
            String lock = RedisFactory.getDefaultClient().get(mobileLockKey);
            if (StringUtils.isNotEmpty(lock)) {
                throw new ServiceException(ServiceException.CODE_100011);
            }

            //生成验证码，如果上一次的验证码未过期，则继续使用
            String mobileKey = Contants.SMS_AAS_TYPE + account;
            String yzm = RedisFactory.getDefaultClient().get(mobileKey);
            if (StringUtils.isEmpty(yzm)) {
                //生成6位数字验证码
                yzm = CommonUtil.createRandom(true, 6);
            }

            //保存短信验证码到缓存，短信5分钟有效，300秒
            RedisFactory.getDefaultClient().set(mobileKey, yzm, 300);
            //保存短信验证锁到缓存，1分钟内不能继续发送验证码，60秒
            RedisFactory.getDefaultClient().set(mobileLockKey, yzm, 60);
            data.put("code", yzm);
            data.put("product", "中仑云平台");

            String templateCode = "SMS_50605097";
            apiSmsService.sendPlatformSms(account, templateCode, data);
            return "";
        }
        return "账号输入错误";
    }

    public String checkYzm(Map<String, Object> params) {
        String account = MapUtils.getString(params, "account");
        String yzm = MapUtils.getString(params, "yzm");
        if (StringUtils.isEmpty(yzm)) {
            return "验证码必须填写";
        }

        if (StringUtils.isEmpty(account)) {
            return "账号必须输入";
        }

        ZLRpcResult rpcResult = apiUserService.checkAccount(params);
        int count = MapUtils.getIntValue(rpcResult.getMap(), "count");
        if (count > 0) {
            return "账号已经存在";
        }

        String mobileKey = Contants.SMS_AAS_TYPE + account;
        String _yzm = RedisFactory.getDefaultClient().get(mobileKey);
        if (StringUtils.isNotEmpty(_yzm) && yzm.equals(_yzm)) {
            return "";
        }
        return "验证码输入错误";
    }

}
