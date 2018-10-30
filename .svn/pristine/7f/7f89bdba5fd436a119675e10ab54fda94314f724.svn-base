package com.wgb.service.impl.dubbo.pwd;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitGetPwdService;
import com.wgb.service.pwd.GetPwdService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author fxs
 * @create 2018-10-08 14:15
 **/
@Service
public class ApitGetPwdServiceImpl implements ApitGetPwdService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitGetPwdServiceImpl.class);

    @Autowired
    private GetPwdService getPwdService;

    public ZLRpcResult sendYzm(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String account = MapUtils.getString(params, "account");
        if (StringUtils.isEmpty(account)) {
            result.setErrorMsg("参数缺失");
            return result;
        }
        String message = getPwdService.sendYzm(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }

    public ZLRpcResult checkYzm(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String account = MapUtils.getString(params, "account");
        String yzm = MapUtils.getString(params, "yzm");
        if (StringUtils.isEmpty(account) || StringUtils.isEmpty(yzm)) {
            result.setErrorMsg("参数缺失");
            return result;
        }
        String message = getPwdService.checkYzm(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }

    public ZLRpcResult updatePassword(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String account = MapUtils.getString(params, "account");
        String yzm = MapUtils.getString(params, "yzm");
        String password = MapUtils.getString(params, "password");
        if (StringUtils.isEmpty(account) || StringUtils.isEmpty(yzm) || StringUtils.isEmpty(password)) {
            result.setErrorMsg("参数缺失");
            return result;
        }
        String message =  getPwdService.updatePassword(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }

    public ZLRpcResult checkAccount(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String account = MapUtils.getString(params, "account");
        if (StringUtils.isEmpty(account)) {
            result.setErrorMsg("参数缺失");
            return result;
        }
        String message = getPwdService.checkAccount(params);
        if (StringUtils.isNotBlank(message)){
            result.setErrorMsg(message);
        }
        return result;
    }
}
