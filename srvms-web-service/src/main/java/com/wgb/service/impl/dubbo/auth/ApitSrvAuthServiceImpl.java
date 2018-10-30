package com.wgb.service.impl.dubbo.auth;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitSrvAuthService;
import com.wgb.service.srv.SrvAuthService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-29 11:00
 **/
@Service
public class ApitSrvAuthServiceImpl implements ApitSrvAuthService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitSrvAuthServiceImpl.class);

    @Autowired
    private SrvAuthService srvAuthService;

    public ZLRpcResult queryAuthByRoleId(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String id = MapUtils.getString(params, "roleid", "");
        if (StringUtils.isNotEmpty(id)) {
            List<Map<String, Object>> authList = srvAuthService.queryAuthListByCondition(params);
            result.setData(authList);
        } else {
            result.setErrorMsg("缺失参数RoleId");
        }
        return result;
    }

    public ZLRpcResult updateAuth(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        srvAuthService.updateAuthForRole(params);
        return result;
    }

}
