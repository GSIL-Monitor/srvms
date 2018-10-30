package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.srv.SrvAssociationShopService;
import com.wgb.service.srv.SrvShopService;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sql.rowset.serial.SerialException;
import java.rmi.server.ServerCloneException;
import java.util.HashMap;
import java.util.Map;

@Service
public class SrvAssociationShopServiceImpl implements SrvAssociationShopService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.SrvAssociationShopServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Autowired
    private ApiShopService apiShopService;

    @Autowired
    private SrvShopService srvShopService;

    @Override
    public Page<?> queryPageList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryPageList", params);
    }

    @Override
    public Map<String, Object> getApplyAssociationData(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getApplyAssociationData", params);
    }

    @Override
    public void updateAssociationStatus(Map<String, Object> params) {
        updateAssociation(params);
        dal.getDalClient().execute(NAMESPACE + "updateAssociation", params);
    }

    @Override
    public void updateAssociation(Map<String, Object> params) {
        updateAssociationShop(params);
        saveShopAndSrvRelation(params);
    }

    /**
     * @param params
     */
    private void updateAssociationShop(Map<String ,Object> params){
        try {
            Map<String ,Object> updateParams = new HashMap<>();
            updateParams.put("servercode" , MapUtils.getString(params ,"servercode"));
            updateParams.put("servername" , MapUtils.getString(params ,"servername"));
            updateParams.put("shopcode" , MapUtils.getString(params ,"shopcode"));
            ZLRpcResult rpcResult = apiShopService.updateAssociationShop(updateParams);
            if (!rpcResult.success()){
                throw new ServiceException(ServiceException.SYS_ERROR);
            }
        }catch (Exception ex){
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
    }

    /**
     * @param params
     */
    private void saveShopAndSrvRelation(Map<String ,Object> params){
        Map<String ,Object> saveParams = new HashMap<>();
        saveParams.put("servercode" , MapUtils.getString(params ,"servercode"));
        saveParams.put("shopcode" , MapUtils.getString(params ,"shopcode"));
        saveParams.put("loginuserid" , MapUtils.getString(params ,"loginuserid"));
        srvShopService.addSrvShop(saveParams);
    }

}
