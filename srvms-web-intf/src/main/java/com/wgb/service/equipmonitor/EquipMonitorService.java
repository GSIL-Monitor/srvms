package com.wgb.service.equipmonitor;

import com.wgb.dao.Page;

import java.util.Map;

public interface EquipMonitorService {
    /**
     * 硬件监测-列表查询
     * @param params
     * @return
     */
    Map<String,Object> queryFaultDetect(Map<String, Object> params);

    /**
     * 硬件监测-详情查询
     * @param params
     * @return
     */
    Map<String, Object> queryShopDetails(Map<String, Object> params);

    /**
     * 硬件监测-历史上报信息列表查询
     * @param params
     * @return
     */
    Page<?> queryHistoryFaultDetect(Map<String, Object> params);

    /**
     * 硬件监测-修改设备保修状态
     * @param params
     */
    void updateShopRepairStatus(Map<String, Object> params);
}
