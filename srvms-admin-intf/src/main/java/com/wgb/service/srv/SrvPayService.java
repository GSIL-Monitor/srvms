package com.wgb.service.srv;

import java.util.Map;

public interface SrvPayService {

    /**
     * 保存支付信息回调函数
     * @param params
     *      订单编号 ordercode
     *      服务商编号 servercode
     *      店铺编号 shopcode
     *      支付金额 payamount
     *      支付时间 paymenttime
     *      支付状态 paystatus
     */
    void updatePayInfo(Map<String, Object> params);
}
