package com.wgb.service.impl.pwd;

import com.wgb.service.CacheService;
import com.wgb.service.dubbo.sms.web.ApiSmsService;
import com.wgb.service.pwd.GetPwdService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import com.wgb.util.Validator;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-10-08 11:18
 **/
@Service
public class GetPwdServiceImpl implements GetPwdService {

    private static final Logger LOGGER = LoggerFactory.getLogger(GetPwdServiceImpl.class);

    @Autowired
    private SrvUserService srvUserService;

    @Autowired
    private CacheService cacheService;

    @Autowired
    private ApiSmsService apiSmsService;



    @Override
    public String sendYzm(Map<String, Object> params) {
        String account = MapUtils.getString(params, "account");
        if (Validator.isMobile(account)) {
            int count = srvUserService.checkAccount(params);
            if (count == 0) {
                return "账号不存在或未进行账号绑定";
            }
            // 生成验证码
            generateVerificationCode(params);
            return "";
        }
        return "账号输入错误";
    }

    public String checkYzm(Map<String, Object> params) {
        String account = MapUtils.getString(params, "account");
        String yzm = MapUtils.getString(params, "yzm");
        if (Validator.isMobile(account)) {
            String _yzm = cacheService.getYzm(account, Contants.SMS_RESET_TYPE);
            if (StringUtils.isNotEmpty(_yzm) && yzm.equals(_yzm)) {
                cacheService.setYzm(yzm, account, Contants.SMS_RESET_TYPE);
                return "";
            }
        } else {
            return "账号格式错误";
        }
        return "验证码输入错误或已过期";
    }

    public String updatePassword(Map<String, Object> params) {
        String account = MapUtils.getString(params, "account");
        String yzm = MapUtils.getString(params, "yzm");
        String _yzm = cacheService.getYzm(account, Contants.SMS_RESET_TYPE);
        if (StringUtils.isNotEmpty(_yzm) && yzm.equals(_yzm)) {
            srvUserService.updatePassword(params);
            return "";
        }
        return "验证码输入错误或已过期";
    }

    @Override
    public String checkAccount(Map<String, Object> params) {
        int count = srvUserService.checkAccount(params);
        if (count == 0) {
            return "账号不存在或未进行账号绑定";
        }
        return "";
    }

    private void generateVerificationCode(Map<String, Object> params){
        String account = MapUtils.getString(params, "account");
        Map<String, Object> data = new HashMap<String, Object>();
        //生成6位数字验证码
        String yzm = CommonUtil.createRandom(true, 6);
        data.put("code", yzm);
        data.put("product", "中仑云平台");
        String templateCode = "SMS_50605095";
        apiSmsService.sendPlatformSms(account, templateCode, data);
        cacheService.setYzm(yzm, account, Contants.SMS_RESET_TYPE);
    }
}
