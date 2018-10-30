package com.wgb.service.renew;

import com.wgb.dao.Page;

import java.text.ParseException;
import java.util.List;
import java.util.Map; /**
 * 商户延期
 */
public interface ExtendService {
    /**
     * 查询延期信息
     * @param params
     * @return
     */
    Page queryExtendInfoByCondition(Map<String, Object> params);

    /**
     * 保存延期订单信息
     * @param params
     * @return
     */
    void saveExtendInfo(Map<String, Object> params) throws ParseException;

    /**
     * 查询详情
     * @param params
     * @return
     */
    List<Map<String,Object>> queryExtendDetail(Map<String, Object> params);
}
