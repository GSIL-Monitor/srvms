package com.wgb.service.impl.dubbo.menu;

import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.srvms.web.ApitSrvMenuService;
import com.wgb.service.srv.SrvMenuService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-10-09 16:38
 **/
@Service
public class ApitSrvMenuServiceImpl implements ApitSrvMenuService {

    @Autowired
    private SrvMenuService srvMenuService;

    public ZLRpcResult getRemoteMenuList(Map<String ,Object> params){
        ZLRpcResult rpcResult = new ZLRpcResult();
        boolean checkResult = checkParams(params);
        if (!checkResult){
            rpcResult.setErrorMsg("参数缺失");
            return rpcResult;
        }
        List<Map<String, Object>> account = srvMenuService.getRemoteMenuList(MapUtils.getString(params, "account"));
        rpcResult.setData(account);
        return rpcResult;
    }

    /**
     * 校验参数
     * @param params
     * @return
     */
    private boolean checkParams(Map<String, Object> params) {
        String account = MapUtils.getString(params, "account");
        if (StringUtils.isBlank(account)){
            return false;
        }
        return true;
    }

}
