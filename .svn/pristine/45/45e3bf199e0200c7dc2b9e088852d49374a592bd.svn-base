package com.wgb.service.impl.dubbo.extend;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.service.dubbo.srvms.web.ApitExtendService;
import com.wgb.service.dubbo.urms.web.ApitShopService;
import com.wgb.service.renew.ExtendService;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ApitExtendServiceImpl implements ApitExtendService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ApitExtendServiceImpl.class);
    @Autowired
    private ExtendService extendService;
    @Autowired
    private ApitShopService shopService;

    /**
     * 查询订单信息
     *
     * @param params
     * @return
     */
    public ZLRpcResult queryExtendInfoList(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Page pageInfo = extendService.queryExtendInfoByCondition(params);
        result.setData(pageInfo);
        return result;
    }

    /**
     * 查询订单信息
     *
     * @param params
     * @return
     */
    public ZLRpcResult findMultipleShop(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String type = MapUtils.getString(params, "type", "");
        if ("single".equals(type)) {
            ZLRpcResult rpcResult = shopService.getShopListRechargeSoftwareForSalver(params);
            result.setData(rpcResult.getData());
        } else if ("multiple".equals(type)) {
            ZLRpcResult rpcResult = shopService.getShopListRechargeForSalver(params);
            result.setData(rpcResult.getData());
        }
        return result;
    }

    /**
     * 保存延期数据
     *
     * @param params
     * @return
     */
    public ZLRpcResult saveExtendInfo(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            extendService.saveExtendInfo(params);
        } catch (ParseException ex) {
            LOGGER.error("查询产品名称异常!", ex);
            result.setErrorMsg("查询产品名称异常");
        }
        return result;
    }

    /**
     * 延期数据详情
     *
     * @param params
     * @return
     */
    public ZLRpcResult queryExtendDetail(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> extendInfoList = extendService.queryExtendDetail(params);
        result.setData(extendInfoList);
        return result;
    }
}
