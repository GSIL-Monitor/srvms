package com.wgb.service.servicebill;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;

import java.util.Map; /**
 * @author fxs
 * @create 2018-09-30 13:54
 **/
public interface ServiceBillService {
    /**
     * 设备返修-列表查询
     * @param params
     * @return
     */
    Page<?> qeuryServiceBillPage(Map<String, Object> params);

    /**
     * 设备返修-保存维修单据
     * @param params
     */
    void saveServiceBill(Map<String, Object> params);

    /**
     *设备返修-跳转确认付款
     * @param params
     * @return
     */
    Map<String ,Object> findPaymentDetail(Map<String, Object> params);

    /**
     * 设备返修-保存付款信息
     * @param params
     */
    void saveServiceBillPaymentMethod(Map<String, Object> params);

    /**
     * 设备返修-取消返修
     * @param params
     */
    void cancelService(Map<String, Object> params);

    /**
     * 设备返修-确认收货
     * @param params
     */
    void confirmReceipt(Map<String, Object> params);

    /**
     * 设备返修-详情页
     * @param params
     * @return
     */
    Map<String,Object> queryServiceBillDetail(Map<String, Object> params);

}
