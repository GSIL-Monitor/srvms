package com.wgb.service.impl.aftersale;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.service.aftersale.AfterSaleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by 11609 on 2017/12/19.
 */
@Service
public class AfterSaleServiceImpl implements AfterSaleService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.aftersale.AfterSaleServiceImpl.";

    protected final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private CommonDalClient dal;

    @Override
    public void updateFlag(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "updateFlag", params);
    }

    @Override
    public Page queryAfterSaleList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryAfterSaleList", params);
    }

    @Override
    public int checkAftersaleTel(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "checkAftersaleTel", params, Integer.class);
    }

    @Override
    public void addRegAfterSaler(Map<String, Object> params) {
//        String manageArea= MapUtils.getString(params,"areas","");
//        String[] sbnewArr = manageArea.split(",");
        dal.getDalClient().execute(NAMESPACE + "addRegAfterSaler", params);
    }

    @Override
    public void updateAfterSale(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "updateAfterSale", params);
    }

    @Override
    public Map<String, Object> queryAfterSaleDetails(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryAfterSaleDetails", params);
    }

    @Override
    public List<Map<String, Object>> queryAreas(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryAreas", params);
    }

    @Override
    public int RegcheckAftersaleTel(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "RegcheckAftersaleTel", params, Integer.class);
    }

    @Override
    public int RegcheckAftersaleId(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "RegcheckAftersaleId", params, Integer.class);
    }

    @Override
    public List<Map<String, Object>> queryAfterSaleListLimit(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryAfterSaleListLimit", params);
    }

    @Override
    public void updateAreaInfo(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE+"updateAreaInfo",params);
    }

    @Override
    public List<Map<String, Object>> queryAllAreas(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryAllAreas", params);
    }

    @Override
    public List<Map<String, Object>> queryAreasByUserid(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryAreasByUserid", params);
    }

    @Override
    public void updateFlagAndArea(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE+"updateFlagAndArea",params);
    }

    @Override
    public Map<String, Object> getAftersaleTel(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getAftersaleTel", params);
    }

}