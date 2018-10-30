package com.wgb.service.impl;

import com.alibaba.dubbo.common.utils.CollectionUtils;
import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.SrvMessageService;
import com.wgb.service.dubbo.bugms.admin.ApiDeviceBugService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.CommonUtil;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SrvMessageServiceImpl implements SrvMessageService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.SrvMessageService.";

    protected final Logger logger = LoggerFactory.getLogger(SrvMessageServiceImpl.class);

    @Autowired
    private CommonDalClient dal;

    @Autowired
    private SrvShopService srvShopService;

    @Autowired
    private ApiDeviceBugService apiDeviceBugService;

    @Override
    public List<Map<String, Object>> queryMessageList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryMessageList", params);
    }

    @Override
    public Page<?> queryMessagePage(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryMessagePage", params);
    }

    public int queryDeviceBugCount(Map<String, Object> params) {
        List<Map<String, Object>> shopList = srvShopService.getSrvShopList(params);
        if (CollectionUtils.isNotEmpty(shopList)) {
            List<String> shopcodeList = CommonUtil.getListStringFromListMap(shopList, "shopcode");
            params.put("shopcodelist", shopcodeList);
            ZLRpcResult result = apiDeviceBugService.getDeviceBugInfo(params);
            return MapUtils.getIntValue(result.getMap(), "deviceHardwareBugnum", 0);
        }
        return 0;
    }

    public Map<String, Object> queryMessageDetail(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryMessageDetail" ,params);
    }
}
