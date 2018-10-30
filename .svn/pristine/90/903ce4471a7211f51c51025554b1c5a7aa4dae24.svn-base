package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.service.srv.SrvRoleService;
import com.wgb.service.srv.SrvService;
import com.wgb.service.srv.SrvUserRoleService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.Contants;
import com.wgb.util.MD5Util;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by 11609 on 2017/12/19.
 */
@Service
public class SrvServiceImpl implements SrvService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.SrvServiceImpl.";

    protected final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private CommonDalClient dal;

    @Autowired
    private SrvUserService srvUserService;

    @Autowired
    private SrvRoleService srvRoleService;

    @Autowired
    private SrvUserRoleService srvUserRoleService;

    @Override
    public Page<?> querySrvPageList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "querySrvPageList", params);
    }

    /**
     * 注册服务商信息
     *
     * @param params
     */
    @Override
    public void addRegSrv(Map<String, Object> params) {
        String regservercode = UUID.randomUUID().toString().replaceAll("-", "");
        params.put("regservercode", regservercode);
        Number number = dal.getDalClient().execute4PrimaryKey(NAMESPACE + "addRegSrv", params);
        String password = MD5Util.GetMD5Code(Contants.SRV_PASSWORD);
        params.put("password", password);
        params.put("servercode", number);
        params.put("username", "1001");
        params.put("flag", MapUtils.getString(params,"flag"));
        //初始化用户
        String userid = srvUserService.addRegUser(params);

        String menus = "";
        //插入管理员角色
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("rolename", "总经理");
        data.put("servercode", number);
        data.put("rolecode", "0001");
        data.put("cangrant", "0");
        data.put("createuser", userid);
        menus = "1,2,5,6,7,8,11,12,13,14,15,16,20,22,23,24,25,26,27,28,29,30,31";

        data.put("menus", menus);
        String roleid = srvRoleService.insertRegInit(data);
        //插入用户管理员角色关系
        Map<String, Object> userRoleMap = new HashMap<String, Object>();
        userRoleMap.put("roleid", roleid);
        userRoleMap.put("userid", userid);
        //初始化用户菜单
        srvUserRoleService.insertRegInit(userRoleMap);

        data.put("rolename", "业务员");
        data.put("servercode", number);
        data.put("rolecode", "0002");
        data.put("cangrant", "1");
        data.put("createuser", userid);
        menus = "1,2,3,4,5,8,10,11,12";

        data.put("menus", menus);
        srvRoleService.insertRegInit(data);

        data.put("rolename", "商务专员");
        data.put("servercode", number);
        data.put("rolecode", "0003");
        data.put("cangrant", "1");
        data.put("createuser", userid);
        menus = "1,2,3,4,8,10,11,12";

        data.put("menus", menus);
        srvRoleService.insertRegInit(data);



    }

    @Override
    public void updateFlag(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "updateFlag", params);
    }

    @Override
    public Map<String, Object> queryServer(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryServer", params);
    }

    @Override
    public Map<String, Object> queryService(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryService", params);
    }

    @Override
    public Map<String, Object> getSrvTel(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getSrvTel", params);
    }

    @Override
    public Map<String, Object> querySrvDetails(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "querySrvDetails", params);
    }

    @Override
    public void updateSrv(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "updateSrv", params);
    }

    public Map<String, Object> queryServerByServerCode(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "queryServerByServerCode" ,params);
    }

    @Override
    public Map<String, Object> getSrvInfo(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getSrvInfo", params);
    }

    public List<Map<String, Object>> queryServerInfoByShopCode(Map<String, Object> params) {
        Object shopcode = params.get("shopcode");
        if (null != shopcode){
            List<String> shopCodeList = new ArrayList<>();
            if( shopcode instanceof List){
                shopCodeList = (List<String>)shopcode;
            }else{
                shopCodeList.add(shopcode.toString());
            }
            params.put("shopcodes" ,shopCodeList);

        }
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "getServerInfo", params);
    }


}