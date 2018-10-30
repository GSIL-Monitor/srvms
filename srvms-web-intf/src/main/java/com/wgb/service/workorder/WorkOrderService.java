package com.wgb.service.workorder;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;

import java.util.List;
import java.util.Map;

public interface WorkOrderService {

    /**
     * 工单-列表查询
     * @param params
     * @return
     */
    Page<?> queryWorkOrderPage(Map<String, Object> params);

    /**
     * 工单-查询设备类型
     * @param params
     * @return
     */
    List<Map<String,Object>> queryHardwareDeviceCategory(Map<String, Object> params);

    /**
     * 工单-查询设备型号
     * @param params
     * @return
     */
    List<Map<String, Object>> queryHardwareByProductCategory(Map<String, Object> params);

    /**
     *查询商户编号列表
     * @param params
     * @return
     */
    List<Map<String,Object>> queryShopcodeListForSrvms(Map<String, Object> params);

    /**
     * 查询分店列表通过服务商
     * @param params
     * @return
     */
    List<Map<String, Object>> queryBranchListByServer(Map<String, Object> params);

    /**
     * 查询商品简述通过商户种类
     * @param params
     * @return
     */
    List<Map<String,Object>> queryPartsByCategoryAndModel(Map<String, Object> params);

    /**
     * 工单-保存工单信息
     * @param params
     */
    void saveWorkOrder(Map<String, Object> params);

    /**
     * 工单-工单详情详情
     * @param params
     * @return
     */
    Map<String ,Object> queryWorkOrderDetail(Map<String, Object> params);

    /**
     * 工单-删除工单
     * @param params
     */
    void deleteWorkOrderByCode(Map<String, Object> params);

    /**
     * 查询待修工单
     * @param params
     * @return
     */
    Page<?> findWorkOrderByWaitRepair(Map<String, Object> params);

    /**
     * 查询工单通过工单号
     * @param params
     * @return
     */
    Map<String, Object> findWorkOrderByWorkOrderCode(Map<String, Object> params);

    /**
     * 更新工单处理状态
     * @param params
     * @return
     */
    String updateWorkOrderStatus(Map<String, Object> params);

    /**
     * 查询工单价格
     * @param params
     * @return
     */
    Map<String,Object> findWorkOrderPrice(Map<String, Object> params);
}
