package com.wgb.service.impl.income;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.service.income.AliIncomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;
@Service
public class AliIncomeServiceImpl implements AliIncomeService {
    @Autowired
    private CommonDalClient dal;
    private static final String NAMESPACE = "shardName.com.wgb.service.impl.income.AliIncomeServiceImpl.";


    @Override
    public Page qyeryAliIncomeList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryAfterSaleList", params);
    }
}
