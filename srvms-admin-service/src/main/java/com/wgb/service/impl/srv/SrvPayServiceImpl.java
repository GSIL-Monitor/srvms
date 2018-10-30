package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.service.srv.SrvPayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class SrvPayServiceImpl implements SrvPayService {

    private static final String NAME_SPACE = "shardName.com.wgb.service.impl.srv.SrvPayServiceImpl.";

    @Autowired
    private CommonDalClient dalClient;

    public void updatePayInfo(Map<String, Object> params) {
        dalClient.getDalClient().execute(NAME_SPACE + "savePayInfoCallback", params);
    }
}
