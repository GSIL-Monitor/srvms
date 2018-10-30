package com.wgb.service.aftersale;

import com.wgb.dao.Page;

import java.util.List;
import java.util.Map;

/**
 * Created by 11609 on 2017/12/19.
 */
public interface AfterSaleService {

    /**
     * 更新flag状态
     * @param params
     */
    void updateFlag(Map<String, Object> params);

    /**
     * 查询售后列表
     * @param params
     * @return
     */
    Page<Map<String, Object>> queryAfterSaleList(Map<String, Object> params);

    /**
     *检查售后电话
     * @param params
     * @return
     */
    int checkAftersaleTel(Map<String, Object> params);

    /**
     * 添加售后服务
     * @param params
     */
    void addRegAfterSaler(Map<String, Object> params);

    /**
     * 更新售后服务
     * @param params
     */
    void updateAfterSale(Map<String, Object> params);

    /**
     * 查询售后详情
     * @param params
     * @return
     */
    Map<String,Object> queryAfterSaleDetails(Map<String, Object> params);

    /**
     * 查询服务区域
     * @param params
     * @return
     */
    List<Map<String,Object>> queryAreas(Map<String, Object> params);

    /**
     * 检查售后电话
     * @param params
     * @return
     */
    int RegcheckAftersaleTel(Map<String, Object> params);

    /**
     * 检查售后id
     * @param params
     * @return
     */
    int RegcheckAftersaleId(Map<String, Object> params);

    /**
     * 分页查询售后列表
     * @param params
     * @return
     */
    List<Map<String,Object>> queryAfterSaleListLimit(Map<String, Object> params);

    /**
     * 更新售后服务区域信息
     * @param params
     */
    void updateAreaInfo(Map<String, Object> params);

    /**
     * 查询所有服务区域
     * @param params
     * @return
     */
    List<Map<String,Object>> queryAllAreas(Map<String, Object> params);

    /**
     * 查询服务区域通过用户id
     * @param params
     * @return
     */
    List<Map<String,Object>> queryAreasByUserid(Map<String, Object> params);

    /**
     * 更新flag状态和服务区域
     * @param params
     */
    void updateFlagAndArea(Map<String, Object> params);

    /**
     * 获得售后电话
     * @param serverMap
     * @return
     */
    Map<String,Object> getAftersaleTel(Map<String, Object> serverMap);
}
