package com.wgb.service.impl;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.mbms.web.ApitMbAssistantCodeService;
import com.wgb.service.dubbo.srvms.web.ApitRenewService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.dubbo.urms.web.ApitShopService;
import com.wgb.service.dubbo.wxms.web.ApitAppService;
import com.wgb.service.renew.RenewService;
import net.sf.json.JSONArray;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 支付调用接口
 *
 * @author fxs
 * @create 2018-09-11 17:10
 **/
@Service
public class ApitRenewServiceImpl implements ApitRenewService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApitRenewServiceImpl.class);

    @Autowired
    private RenewService renewService;
    @Autowired
    private ApitShopService shopService;
    @Autowired
    private ApiShopService apiShopService;
    @Autowired
    private ApitMbAssistantCodeService apitMbAssistantCodeService;
    @Autowired
    private ApitAppService apitAppService;


    public ZLRpcResult updateRenewPayInfo(Map<String, Object> params) {
        LOGGER.info("修改订单支付状态入参:{}", params);
        ZLRpcResult rpcResult = new ZLRpcResult();

        renewService.updateRenewPayInfo(params);
        return rpcResult;
    }


    public ZLRpcResult updateRenewStatusByProductCode(Map<String, Object> params) {
        LOGGER.info("修改订单支付状态入参:{}", params);
        ZLRpcResult rpcResult = new ZLRpcResult();
        renewService.updateRenewStatusByProductCode(params);
        return rpcResult;
    }

    /**
     * 查询产品名称
     *
     * @param params
     * @return
     */
    public ZLRpcResult queryProductInfoByCondition(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> productList = renewService.queryProductInfoByCondition(new HashMap<String, Object>());
        result.setData(productList);
        return result;
    }

    /**
     * 查询商户续费订单列表
     *
     * @param params
     * @return
     */
    public ZLRpcResult queryOrderInfoList(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Page pageInfo = renewService.queryOrderInfoByCondition(params);
        result.setData(pageInfo);
        return result;
    }

    /**
     * 查询续费详情
     *
     * @param params
     * @return
     */
    public ZLRpcResult merchantStandardDetail(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> merchantDetail = renewService.queryMerchantDetail(params);
        result.setData(merchantDetail);
        return result;
    }

    /**
     * 删除续费订单
     *
     * @param params
     * @return
     */
    public ZLRpcResult deleteOrderInfo(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        String message = renewService.deleteOrderInfo(params);
        result.setData(message);
        return result;
    }

    /**
     * 获取营销助手码
     *
     * @param params
     * @return
     */
    public ZLRpcResult querysaleassistantcode(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Map<String, Object> map = renewService.querysaleassistantcode(params);
        result.setData(map);
        return result;
    }

    /**
     * 查询营销助手码
     *
     * @param params
     * @return
     */
    public ZLRpcResult queryProductList(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        Page pageInfo = renewService.queryProductInfo(params);
        result.setData(pageInfo);
        return result;
    }

    /**
     * 页面跳转
     *
     * @param params
     * @return
     */
    public ZLRpcResult writeRenew(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        //查产品信息
        Map<String, Object> productCode = new HashMap<>();
        productCode.put("componentcode", MapUtils.getString(params, "productcode"));
        Map<String, Object> productInfo = renewService.queryProductInfoDetail(productCode);

        // 查折扣
        Map<String, Object> queryServerDiscountParams = new HashMap<>();
        queryServerDiscountParams.put("servercode", MapUtils.getString(params, "servercode"));
        Map<String, Object> serverDiscount = renewService.queryServerDiscount(queryServerDiscountParams);

        productInfo.putAll(serverDiscount);
        result.setData(productInfo);
        return result;
    }

    /**
     * 查询单店信息
     *
     * @param params
     * @return
     */
    public ZLRpcResult findSingleShop(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        ZLRpcResult rpcResult = shopService.getShopListSoftwareForSalver(params);
        result.setData(rpcResult.getData());
        return result;
    }

    /**
     * 单店支付生成billcode
     *
     * @param params
     * @return
     */
    public ZLRpcResult payAgainMerchantStandard(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            String billCode = renewService.saveOrderInfoByBillCode(params);
            result.setData(billCode);
        } catch (ParseException ex) {
            LOGGER.error("获取续费产品名称异常", ex);
            result.setErrorMsg("获取续费产品名称异常");
        }
        return result;
    }

    /**
     * 微信小程序选择门店
     *
     * @param params
     * @return
     */
    public ZLRpcResult findMultipleShop(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        //查微信小程序的门店
        ZLRpcResult rpcResult = apiShopService.queryShopcodeListForSrvms(params);
        List<Map<String, Object>> list = rpcResult.getList();
        Map<String, Object> shopmap = new HashMap();
        List<String> shoplist = new ArrayList<>();

        for (Map<String, Object> map : list) {
            String shopcode = MapUtils.getString(map, "shopcode");
            shoplist.add(shopcode);
        }
        //假如shoplist为空，不调queryMiniAppInfos接口，直接返回空list
        if (shoplist.size() == 0) {
            List<String> branchlist = new ArrayList<>();
            result.setData(branchlist);
            return result;
        }
        shopmap.put("shopcodelist", shoplist);
        ZLRpcResult rpcResult1 = apitAppService.queryMiniAppInfos(shopmap);
        result.setData(rpcResult1.getData());
        return result;
    }

    /**
     * 根据billcode查订单信息
     *
     * @param params
     * @return
     */
    public ZLRpcResult queryPayOrderInfoByBillCode(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        List<Map<String, Object>> orderInfo = renewService.queryPayOrderInfoByBillCode(params);
        result.setData(orderInfo);
        return result;
    }

    /**
     * 购买新的营销助手码的门店
     *
     * @param params
     * @return
     */
    public ZLRpcResult findallShop(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        ZLRpcResult rpcResult = shopService.getShopListAllForSalver(params);
        result.setData(rpcResult.getData());
        return result;
    }

    /**
     * 已有营销助手码续费门店
     *
     * @param params
     * @return
     */
    public ZLRpcResult findMultipleShop5(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        ZLRpcResult rpcResult = apiShopService.queryShopcodeListForSrvms(params);
        List<Map<String, Object>> list = rpcResult.getList();
        Map<String, Object> shopmap = new HashMap();
        List<String> shoplist = new ArrayList<>();

        for (Map<String, Object> map : list) {
            String shopcode = MapUtils.getString(map, "shopcode");
            shoplist.add(shopcode);
        }
        //假如shoplist为空，queryAssistantCodeForSrvms，直接返回空list
        if (shoplist.size() == 0) {
            List<String> branchlist = new ArrayList<>();
            result.setData(branchlist);
            return result;
        }
        shopmap.put("shopcodelist", shoplist);

        ZLRpcResult rpcResultforass = apitMbAssistantCodeService.queryAssistantCodeForSrvms(shopmap);
        result.setData(rpcResultforass.getList());
        return result;
    }

    /**
     * 微信营销插件的门店
     *
     * @param params
     * @return
     */
    public ZLRpcResult findwechatallShop(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        ZLRpcResult rpcResult1 = null;
        rpcResult1 = apiShopService.queryShopcodeListForSrvms(params);
        List<Map<String, Object>> list = rpcResult1.getList();
        List<String> shoplist = new ArrayList<>();

        for (Map<String, Object> map : list) {
            String shopcode = MapUtils.getString(map, "shopcode");
            shoplist.add(shopcode);
        }

        //封装新参数
        Map<String, Object> shopmap = new HashMap();
        shopmap.put("shopcodelist", shoplist);
        shopmap.put("page", MapUtils.getIntValue(params, "page"));
        shopmap.put("pageSize", MapUtils.getIntValue(params, "pageSize"));

        ZLRpcResult rpcResult = apitAppService.queryShopAppInfos(shopmap);
        result.setData(rpcResult.getData());
        return result;
    }

    /**
     * 连锁续费门店查询
     *
     * @param params
     * @return
     */
    public ZLRpcResult findMultipleShopRenew(Map<String, Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        ZLRpcResult rpcResult = shopService.getShopListForSalver(params);  //续费连锁
        result.setData(rpcResult.getData());
        return result;
    }
}
