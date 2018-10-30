package com.wgb.service.impl.admin;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.service.admin.AdminFeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by wgb on 2017/3/21.
 */
@Service
public class AdminFeedbackServiceImpl implements AdminFeedbackService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.admin.AdminFeedbackServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Override
    public Page<?> queryPageList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryPageList", params);
    }


    @Override
    public void delDomain(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "delDomain", params);
    }

    @Override
    public Map<String, Object> getFeedbackInfo(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getFeedbackInfo", params);
    }


}
