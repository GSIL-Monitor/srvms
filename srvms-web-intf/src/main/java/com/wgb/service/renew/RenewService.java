package com.wgb.service.renew;

import com.wgb.dao.Page;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

/**
 * 商户续费
 */
public interface RenewService {

    /**
     * 查询商品名称
     *  @param params
     *  @return
     */
    List<Map<String ,Object>> queryProductInfoByCondition(Map<String, Object> params);

    /**
     * 查询订单新
     * @param params
     * @return
     */
    Page queryOrderInfoByCondition(Map<String, Object> params);

    /**
     * 查询单店版详情
     * @param params
     * @return
     */
    List<Map<String, Object>> queryMerchantDetail(Map<String, Object> params);

    /**
     * 查询连锁店详情
     * @param params
     * @return
     */
    Map<String,Object> queryMerchantChainDetail(Map<String, Object> params);

    /**
     * 删除订单信息
     * @param params
     * @return
     */
    String deleteOrderInfo(Map<String, Object> params);


    /**
     * 查询订单信息
     * @param params
     * @return
     */
    String saveOrderInfoByBillCode(Map<String, Object> params) throws ParseException;

    /**
     * 修改支付信息
     * @param params
     */
    void updateRenewPayInfo(Map<String, Object> params);

    /**
     * 查询商品信息
     * @param params
     * @return
     */
    Page queryProductInfo(Map<String, Object> params);
    /**
     * 查询营销助手码
     * @param params
     * @return
     */
    Map<String,Object> querysaleassistantcode(Map<String, Object> params);

    /**
     * 查询服务商折扣价格
     * @param params
     * @return
     */
    Map<String ,Object> queryServerDiscount(Map<String ,Object> params);
    public List<Map<String, Object>> savewechatOrderInfoByBillCode(Map<String, Object> params) throws ParseException;
    /**
     * 查询商品详情
     * @param productCode
     * @return
     */
    Map<String,Object> queryProductInfoDetail(Map<String, Object> productCode);

    /**
     * 查询订单展示页面详情
     * @param params
     * @return
     */
    List<Map<String,Object>> queryPayOrderInfoByBillCode(Map<String, Object> params);

    /**
     * 变成产品变更订单状态
     * @param params
     */
    void updateRenewStatusByProductCode(Map<String, Object> params);
}
