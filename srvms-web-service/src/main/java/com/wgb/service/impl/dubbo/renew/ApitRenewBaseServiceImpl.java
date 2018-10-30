package com.wgb.service.impl.dubbo.renew;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.service.dubbo.mbms.web.ApitMbAssistantCodeService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.dubbo.urms.web.ApitShopService;
import com.wgb.service.dubbo.wxms.web.ApitAppService;
import com.wgb.service.renew.RenewService;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ApitRenewBaseServiceImpl {
    private static final Logger LOGGER = LoggerFactory.getLogger(ApitRenewBaseServiceImpl.class);
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


    /**
     * 查询产品名称
     * @param params
     * @return
     */
    public ZLRpcResult queryProductInfoByCondition(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            List<Map<String, Object>> productList = renewService.queryProductInfoByCondition(new HashMap<String, Object>());
            result.setData(productList);
        }catch (BusinessException ex){
            LOGGER.error("查询产品名称异常!",ex);
        }catch (Exception e){
            LOGGER.error("查询产品名称异常!",e);
        }
        return result;
    }
    /**
     * 查询商户续费订单列表
     * @param params
     * @return
     */
    public ZLRpcResult queryOrderInfoList(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            Page pageInfo = renewService.queryOrderInfoByCondition(params);
            result.setData(pageInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询商户续费订单列表!",ex);
        }catch (Exception e){
            LOGGER.error("查询商户续费订单列表!",e);
        }
        return result;
    }
    /**
     * 查询续费详情
     * @param params
     * @return
     */
    public ZLRpcResult merchantStandardDetail(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            List<Map<String, Object>> merchantDetail = renewService.queryMerchantDetail(params);
            result.setData(merchantDetail);
        }catch (BusinessException ex){
            LOGGER.error("查询续费详情",ex);
        }catch (Exception e){
            LOGGER.error("查询续费详情",e);
        }
        return result;
    }
    /**
     * 删除续费订单
     * @param params
     * @return
     */
    public ZLRpcResult deleteOrderInfo(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            String message = renewService.deleteOrderInfo(params);
            result.setData(message);
        }catch (BusinessException ex){
            LOGGER.error("删除续费订单异常",ex);
        }catch (Exception e){
            LOGGER.error("删除续费订单异常",e);
        }
        return result;
    }
    /**
     * 获取续费产品信息
     * @param params
     * @return
     */
    public ZLRpcResult queryProductList(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            Page pageInfo = renewService.queryProductInfo(params);
            result.setData(pageInfo);
        }catch (BusinessException ex){
            LOGGER.error("获取续费产品名称异常",ex);
        }catch (Exception e){
            LOGGER.error("获取续费产品名称异常",e);
        }
        return result;
    }
    /**
     * 查询单店信息
     * @param params
     * @return
     */
    public ZLRpcResult findSingleShop(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            ZLRpcResult rpcResult  = shopService.getShopListSoftwareForSalver(params);
            result.setData(rpcResult.getData());
        }catch (BusinessException ex){
            LOGGER.error("获取续费产品名称异常",ex);
        }catch (Exception e){
            LOGGER.error("获取续费产品名称异常",e);
        }
        return result;
    }
    /**
     * 单店支付生成billcode
     * @param params
     * @return
     */
    public ZLRpcResult payAgainMerchantStandard(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            String billCode  = renewService.saveOrderInfoByBillCode(params);
            result.setData(billCode);
        }catch (BusinessException ex){
            LOGGER.error("获取续费产品名称异常",ex);
        }catch (Exception e){
            LOGGER.error("获取续费产品名称异常",e);
        }
        return result;
    }
    /**
     * 微信小程序选择门店
     * @param params
     * @return
     */
    public ZLRpcResult findMultipleShop(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
        ZLRpcResult    rpcResult  = apiShopService.queryShopcodeListForSrvms(params);
            List<Map<String,Object>> list=rpcResult.getList();
            Map<String,Object> shopmap=new HashMap();
            List<String> shoplist=new ArrayList<>();

            for(Map<String,Object> map:list){
                String shopcode=MapUtils.getString(map,"shopcode");
                shoplist.add(shopcode);
            }
            if(shoplist.size()==0){
                shoplist.add("12345") ;
            }
            shopmap.put("shopcodelist",shoplist);
            ZLRpcResult    rpcResult1  = apitAppService.queryMiniAppInfos(shopmap);
            result.setData(rpcResult1.getData());
        }catch (BusinessException ex){
            LOGGER.error("微信小程序选择门店异常",ex);
        }catch (Exception e){
            LOGGER.error("微信小程序选择门店异常",e);
        }
        return result;
    }
    /**
     * 根据billcode查订单信息
     * @param params
     * @return
     */
    public ZLRpcResult queryPayOrderInfoByBillCode(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            List<Map<String ,Object>> orderInfo = renewService.queryPayOrderInfoByBillCode(params);
            result.setData(orderInfo);
        }catch (BusinessException ex){
            LOGGER.error("根据billcode查订单信息异常",ex);
        }catch (Exception e){
            LOGGER.error("根据billcode查订单信息异常",e);
        }
        return result;
    }
    /**
     *购买新的营销助手码的门店
     * @param params
     * @return
     */
    public ZLRpcResult findallShop(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            ZLRpcResult rpcResult  = shopService.getShopListAllForSalver(params);
            result.setData(rpcResult.getData());
        }catch (BusinessException ex){
            LOGGER.error("根据billcode查订单信息异常",ex);
        }catch (Exception e){
            LOGGER.error("根据billcode查订单信息异常",e);
        }
        return result;
    }
    /**
     *已有营销助手码续费门店
     * @param params
     * @return
     */
    public ZLRpcResult findMultipleShop5(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
         ZLRpcResult   rpcResult  = apiShopService.queryShopcodeListForSrvms(params);
            List<Map<String,Object>> list=rpcResult.getList();
            Map<String,Object> shopmap=new HashMap();
            List<String> shoplist=new ArrayList<>();

            for(Map<String,Object> map:list){
                String shopcode=MapUtils.getString(map,"shopcode");
                shoplist.add(shopcode);
            }
            if(shoplist.size()==0){
                shoplist.add("12345") ;
            }
            shopmap.put("shopcodelist",shoplist);

          ZLRpcResult  rpcResultforass=apitMbAssistantCodeService.queryAssistantCodeForSrvms(shopmap);
           result.setData(rpcResultforass.getList());
        }catch (BusinessException ex){
            LOGGER.error("根据billcode查订单信息异常",ex);
        }catch (Exception e){
            LOGGER.error("根据billcode查订单信息异常",e);
        }
        return result;
    }
    /**
     *微信营销插件的门店
     * @param params
     * @return
     */
    public ZLRpcResult findwechatallShop(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
            ZLRpcResult rpcResult1 = null;
            rpcResult1  = apiShopService.queryShopcodeListForSrvms(params);
            List<Map<String,Object>> list=rpcResult1.getList();
            Map<String,Object> shopmap=new HashMap();
            List<String> shoplist=new ArrayList<>();
            for(Map<String,Object> map:list){
                String shopcode=MapUtils.getString(map,"shopcode");
                shoplist.add(shopcode);
            }
            result.setData(shoplist);
        }catch (BusinessException ex){
            LOGGER.error("根据billcode查订单信息异常",ex);
        }catch (Exception e){
            LOGGER.error("根据billcode查订单信息异常",e);
        }
        return result;
    }
    /**
     * 连锁续费门店查询
     * @param params
     * @return
     */
    public ZLRpcResult findMultipleShopRenew(Map<String ,Object> params) {
        ZLRpcResult result = new ZLRpcResult();
        try {
          ZLRpcResult  rpcResult  = shopService.getShopListForSalver(params);  //续费连锁
            result.setData(rpcResult.getData());
        }catch (BusinessException ex){
            LOGGER.error("连锁续费门店查询异常",ex);
        }catch (Exception e){
            LOGGER.error("连锁续费门店查询异常",e);
        }
        return result;
    }
}
