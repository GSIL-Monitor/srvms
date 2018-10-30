package com.wgb.service.impl;

import com.wgb.dao.CommonDalClient;
import com.wgb.service.SeqGenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wgb on 2016/8/27.
 */
@Service
public class SeqGenServiceImpl implements SeqGenService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.SeqGenServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Override
    public String getSeqCode(String type) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("type", type);
        Number number = dal.getDalClient().execute4PrimaryKey(NAMESPACE + "getSeqCode", params);
        return number.toString();
    }

    @Override
    public String getBarCode(String shopcode) {
        return null;
    }
}
