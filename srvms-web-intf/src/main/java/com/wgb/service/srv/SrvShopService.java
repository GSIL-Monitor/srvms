package com.wgb.service.srv;

import com.wgb.dao.Page;

import java.util.List;
import java.util.Map;

public interface SrvShopService {
    /**
     * 更新商户标注
     *
     * @param params
     */
    void updateShopfollow(Map<String, Object> params);

    /**
     * 添加商户关联信息
     *
     * @param params
     */
    void addRegShop(Map<String, Object> params);

    /**
     * 获取标注信息
     *
     * @param params
     * @return
     */
    Map<String, Object> getShopFollowInfo(Map<String, Object> params);

    /**
     * 服务商注册商户
     *
     * @param params
     */
    void addSrvShop(Map<String, Object> params);

    /**
     * 首页统计服务商关联商户数量
     *
     * @param params
     * @return
     */
    Map<String, Object> getShopCountData(Map<String, Object> params);

    Map<String, Object> getChainGrowthRate(Map<String, Object> params);

    /**
     * 根据服务商Code查询名下商户ShopCode
     *
     * @param params Contants.LOGIN_USER_SERVER_CODE -- 经销商编码
     * @return shopCode -- 商户编码
     */
    List<Map<String, Object>> queryShopCodeByServiceCode(Map<String, Object> params);

    /**
     *  根据商户Code查询店铺下的有效和无效门店数量
     * @param shopCode
     *         shopCode -- 商户ID
     * @return
     *      SrvShopServiceImpl.EFFECTIVE_STORE 有效门店
     *      SrvShopServiceImpl.INVALID_STORE 无效门店
     *      SrvShopServiceImpl.TOTAL_STORE 总门店
     */
    Map<String ,Integer> queryBranchCountByShopCode( List<Map<String, Object>> shopCode);

    /**
     *  根据商户Code查询指定日期到期的门店数量
     * @param maturityDaysValue 指定到期天数
     * @param shopCodeList
     *         shopCode -- 商户ID
     * @return
     *      总即将到期门店数
     */
    int queryMaturityStoreNumsByDaysAndShopCode(Integer maturityDaysValue, List<Map<String, Object>> shopCodeList);

    /**
     * 根据商户Code查询指定日期到期的门店数量
     * @param maturityDaysValue 指定到期天数
     * @param shopCodeList
     *      shopCode -- 商户ID
     * @return
     *      每个门店即将到期门店
     *          返回值key 为当前门店的 shopCode 值，例如 100000430 --> 2
     */
    List<Map<String ,Object>> queryMaturityNumStoreByDaysAndShopCodes(Integer maturityDaysValue, List<Map<String, Object>> shopCodeList);

    /**
     * 根据服务商ID查询指定时间段的新增门店，缴费门店和未缴费门店
     * @param params
     *         servercode 服务商ID
     *         startTime 起始时间
     *         endTime 结束时间
     * @return
     *        totalBranch  总门店
     *        paymentBranch  付费门店
     *        noPaymentBranch 未付费门店
     */
    Map<String,Object> queryNewBranchNumsBuyServerCode(Map<String, Object> params);

    /**
     *  根据条件查询店铺信息
     * @param params
     * @return
     */
    Page<?> queryShopAndBranchNums(Map<String, Object> params);

    /**
     * 根据店铺Code查询店铺下商户信息
     * @param params
     * @return
     */
    List<Map<String,Object>> queryBranchInfoByShopCode(Map<String, Object> params);


    /**
     *  查询商品信息
     * @param params
     * @return
     */
    List<Map<String,Object>> queryProductInfo(Map<String, Object> params);


    Map<String,Object> getSrvShopInfo(Map<String, Object> params);

    List<Map<String,Object>> getSrvShopList(Map<String, Object> params);
    /**
     * 根据到期时间查询即将到期门店信息
     * @param params
     * @return
     */
    int getExpireBranchCount(Map<String, Object> params);

    /**
     * 查询新增门店信息
     * @param params
     * @return
     */
    Map<String,Object> getStoreCount(Map<String, Object> params);

    /**
     * 根据时间和服务商编码查询新增用户
     * @param params
     * @return
     */
    Map<String, Object> getNewStoreCount(Map<String, Object> params);

    /**
     * 根据时间和服务商编码查询新增用户
     * @param params
     * @return
     */
    Map<String,Object> getShopFollowInfoByFormTable(Map<String, Object> params);

    /**
     * 添加商户关联信息
     *
     * @param params
     */
    void insertServerShop(Map<String, Object> params);

    /**
     * 根据时间和服务商编码查询新增用户
     * @param params
     * @return
     */
    Map<String, Object> getServerCodeByCode(Map<String, Object> params);

    Page<?> querySrvShopPage(Map<String, Object> params);

    Map<String,Object> queryShopDetail(Map<String, Object> params);

    Page queryBranchList(Map<String, Object> params);

    List<Map<String,Object>> rechargeDetail(Map<String, Object> params);

}
