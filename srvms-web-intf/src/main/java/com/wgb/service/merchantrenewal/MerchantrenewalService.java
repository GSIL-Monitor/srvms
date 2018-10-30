package com.wgb.service.merchantrenewal;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

public interface MerchantrenewalService {
    /**
     * 插入微信更新
     * @param params
     */
    void insertWechatRenew(Map<String, Object> params);

    /**
     * 保存订单信息通过运单号
     * @param params
     * @return
     * @throws ParseException
     */
    List<Map<String,Object>> saveOrderInfoByBillCode(Map<String, Object> params) throws ParseException;
}
