package com.wgb.service.impl.dubbo;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.aftersale.AfterSaleService;
import com.wgb.service.dubbo.srvms.admin.ApiPubSrvService;
import com.wgb.service.srv.SrvService;
import com.wgb.service.srv.SrvShopService;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yjw on 2017/9/27
 */
@Service
public class ApiPubSrvServiceImpl implements ApiPubSrvService {

    public static final Logger logger = LoggerFactory.getLogger(ApiPubSrvServiceImpl.class);

    @Autowired
    private SrvService srvService;

    @Autowired
    private SrvShopService srvShopService;

    @Autowired
    private AfterSaleService afterSaleService;

    @Override
    public ZLRpcResult getSrvTel(Map<String, Object> params) {
        ZLRpcResult rpcResult = new ZLRpcResult();

        try {
            Map<String, Object> data = new HashMap<>();
            Map<String, Object> serverMap = new HashMap<>();
            Map<String, Object> aftersalesMap = new HashMap<>();
            //取服务商编码
            Map<String, Object> shopMap = srvShopService.getServercode(params);

            if (MapUtils.isNotEmpty(shopMap)) {
                serverMap = srvService.getSrvInfo(shopMap);
                //根据售后数据查询售后电话
                aftersalesMap = afterSaleService.getAftersaleTel(serverMap);
            }
            //根据服务商编码获取售后数据
            data.put("aftersales", MapUtils.getString(serverMap, "aftersales", ""));
            data.put("aftersalesname", MapUtils.getString(serverMap, "aftersalesname", ""));
            data.put("servername", MapUtils.getString(serverMap, "servername", ""));
            data.put("servercode", MapUtils.getString(serverMap, "servercode", ""));
            data.put("telephone", MapUtils.getString(aftersalesMap, "telephone", ""));
            rpcResult.setData(data);
        } catch (ServiceException e) {
            // 异常处理
            logger.error("API根据商户id获取服务商手机号异常记录异常，输入参数 =" + params, e);
            rpcResult.setErrorCode(e.getCode());
        } catch (Exception e) {
            // 异常处理
            logger.error("API根据商户id获取服务商手机号异常记录异常，输入参数 =" + params, e);
            rpcResult.setErrorCode(ServiceException.SYS_ERROR);
        }
        return rpcResult;
    }

    public ZLRpcResult queryServerInfoByShopCode(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            List<Map<String, Object>> maps = srvService.queryServerInfoByShopCode(params);
            result.setData(maps);
        } catch (ServiceException e) {
            logger.error("查询服务商信息失败！", e);
            result.setErrorCode(e.getCode());
            result.setErrorMsg(e.getMessage());
        } catch (Exception e) {
            logger.error("查询服务商信息失败！", e);
            result.setErrorCode(9999);
            result.setErrorMsg("系统未知异常!");
        }
        return result;
    }


}
