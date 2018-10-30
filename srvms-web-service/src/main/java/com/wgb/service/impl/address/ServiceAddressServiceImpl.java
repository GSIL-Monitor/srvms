package com.wgb.service.impl.address;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.service.address.ServiceAddressService;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-07-12 11:39
 **/
@Service
public class ServiceAddressServiceImpl implements ServiceAddressService {

    private static final String NAME_SPACE = "shardName.com.wgb.service.impl.address.ServiceAddressServiceImpl.%s";

    @Autowired
    private CommonDalClient dalClient;


    public Map<String, Object> queryServiceAddress(Map<String ,Object> params) {
        return dalClient.getReadOnlyDalClient().queryForMap(String.format(NAME_SPACE ,"queryServiceAddress") , params);
    }

    public void saveServiceAddress(Map<String ,Object> params) {
         dalClient.getDalClient().execute(String.format(NAME_SPACE ,"saveServiceAddress") , params);
    }

    public void updateServiceAddress(Map<String, Object> params) {
        Map<String ,Object> saveOrUpdateParams = new HashMap<>();
        saveOrUpdateParams.put("servercode" ,MapUtils.getString(params ,"servercode"));
        saveOrUpdateParams.put("contact" ,MapUtils.getString(params ,"companycontacts"));
        saveOrUpdateParams.put("contacttel" ,MapUtils.getString(params ,"companycontactstel"));
        saveOrUpdateParams.put("address" ,MapUtils.getString(params ,"companyaddress"));
        // 查询
        Map<String, Object> map = queryServiceAddress(params);
        if (MapUtils.isNotEmpty(map)){
            dalClient.getDalClient().execute(String.format(NAME_SPACE ,"updateServiceAddress") , saveOrUpdateParams);
        }else{
            saveServiceAddress(saveOrUpdateParams);
        }
    }
}
