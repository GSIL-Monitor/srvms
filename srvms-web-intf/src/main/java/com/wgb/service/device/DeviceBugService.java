package com.wgb.service.device;

import java.util.List;
import java.util.Map; /**
 * @author fxs
 * @create 2018-09-29 13:57
 **/
public interface DeviceBugService{
    /**
     * 查询硬件设备汇总
     * @param params
     * @return
     */
    Map<String,Object> queryCollectDeviceInfo(Map<String, Object> params);

    /**
     * 查询硬件故障总数和在线设备总数
     * @param params
     * @return
     */
    Map<String,Object> getDeviceDataCount(Map<String, Object> params);

    /**
     *  查询在线设备
     * @param params
     * @return
     */
    List<Map<String,Object>> getOnlineDeviceAnalyzeData(Map<String, Object> params);

    /**
     * 查询硬件故障
     * @param params
     * @return
     */
    List<Map<String,Object>> getHardwareBugCountData(Map<String, Object> params);
}
