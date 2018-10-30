package com.wgb.service.srv;

import com.wgb.dao.Page;

import java.util.List;
import java.util.Map;

public interface SrvRenewService {

    /**
     *  保存商户续费信息
     * @param params
     *      订单信息
     * @return
     */
    List<Object> saveBranchRenew(Map<String, Object> params);

    /**
     * 根据条件查询店铺续费列表
     * @param params
     * @return
     */
    Page<?> queryRenewBranchView(Map<String, Object> params);

    /**
     * 根据订单编号删除订单信息
     * @param params
     * @return
     */
    String deleteOrderByOrderId(Map<String, Object> params);

    /**
     * 根据订单编号，查询订单main表详情
     * @param params
     * @return
     */
    List<Map<String, Object>> queryOrderMainDetailByOrderId(Map<String, Object> params);

    /**
     * 根据订单编号，查询订单Item表详情
     * @param params
     * @return
     */
    List<Map<String, Object>> queryOrderItemDetailByOrderId(Map<String, Object> params);

    /**
     * 根据条件查询订单信息
     * @param params
     * @return
     */
    Map<String,Object> queryOrderInfoByCondition(Map<String, Object> params);

    /**
     * 商户延长试用期
     * @param params
     * @return
     */
    String extendProbation(Map<String, Object> params);

    /**
     *  校验是否可以延期
     * @param params
     * @return
     */
    String checkExtendProbationCondition(Map<String, Object> params);
}
