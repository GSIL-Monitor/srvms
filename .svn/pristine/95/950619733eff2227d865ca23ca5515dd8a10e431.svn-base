package com.wgb.service.impl.home;

import com.wgb.service.SrvMessageService;
import com.wgb.service.SrvUserRoleService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.home.HomeService;
import com.wgb.service.srv.SrvAuthService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.Contants;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.omg.CORBA.OBJ_ADAPTER;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-10-08 9:49
 **/
@Service
public class HomeServiceImpl implements HomeService{
    private static final Logger LOGGER = LoggerFactory.getLogger(HomeServiceImpl.class);

    private static final Integer MATURITY_DAYS_VALUE = 10; // 默认到期天数

    @Autowired
    private SrvShopService srvShopService;

    @Autowired
    private SrvMessageService srvMessageService;

    @Autowired
    private SrvUserRoleService srvUserRoleService;

    @Autowired
    private SrvAuthService srvAuthService;
    public Map<String, Object> queryIndexInfo(Map<String, Object> params) {
        Map<String ,Object> result = new HashMap<>();
        // 查询当前是否有权限访问消息列表和bug列表
        int auth = checkBugAuth(params);
        result.put("bugauth" ,auth);
        // 查询设备bug总数
        queryDeviceBugCount(params ,result);
        //获取服务商消息公告
        queryMessageList(params ,result);
        //获取服务商名下商户数量统计
        getNewStoreCount(params ,result);
        // 查询到期天数
        getExpireBranchCount(params ,result);
        // 查询新增门店
        getStoreCount(params ,result);
        return result;
    }

    private int checkBugAuth(Map<String, Object> params) {
        // 查询当前登录用户所有菜单
        List<Map<String ,Object>> menus = srvUserRoleService.getRoleListForServer(params);
        // 判断是否有故障检测权限
        String id = "23";
        // 判断是否包含
        for (Map<String ,Object> menu : menus){
            String authId = MapUtils.getString(menu ,"menus");
            if (StringUtils.isNotBlank(authId) && authId.contains(id)){
                return 1;
            }
        }
        return 0;
    }

    @Override
    public int getExpireBranchCount(Map<String, Object> params) {
        return srvShopService.getExpireBranchCount(params);
    }

    @Override
    public Map<String, Object> getStoreCount(Map<String, Object> params) {
        return  srvShopService.getStoreCount(params);
    }

    private void getStoreCount(Map<String ,Object> params ,Map<String ,Object> result){
        // 查询新增门店
        Map<String, Object> queryNewBranchCountParams = new HashMap<>();
        queryNewBranchCountParams.putAll(params);
        queryNewBranchCountParams.put("startTime", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        queryNewBranchCountParams.put("endTime", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        Map<String, Object> shopResult = srvShopService.getStoreCount(queryNewBranchCountParams);
        result.put("newStoreCount", shopResult);
    }

    private void getExpireBranchCount(Map<String ,Object> params ,Map<String ,Object> result){
        // 查询到期天数
        Map<String, Object> queryExpireBranchCountParams = new HashMap<>();
        queryExpireBranchCountParams.putAll(params);
        queryExpireBranchCountParams.put("exprieDays", MATURITY_DAYS_VALUE);
        int expireBranchCount = srvShopService.getExpireBranchCount(queryExpireBranchCountParams);
        result.put("expireBranchCount", expireBranchCount);
    }

    private void getNewStoreCount(Map<String ,Object> params ,Map<String ,Object> result){
        //获取服务商名下商户数量统计
        Map<String, Object> queryBranchCountParams = new HashMap<>();
        queryBranchCountParams.putAll(params);
        queryBranchCountParams.put("startTime", "2000-01-01");
        queryBranchCountParams.put("endTime", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        Map<String, Object> storeCount = srvShopService.getNewStoreCount(queryBranchCountParams);
        result.put("storeCount", storeCount);
    }

    private void queryMessageList(Map<String ,Object> params ,Map<String ,Object> result){
        //获取服务商消息公告
        List<Map<String, Object>> messageList = srvMessageService.queryMessageList(params);
        result.put("messageList", messageList);
    }

    private void queryDeviceBugCount(Map<String ,Object> params ,Map<String ,Object> result){
        // 获取待处理硬件故障
        int deviceBugCount = srvMessageService.queryDeviceBugCount(params);
        result.put("deviceBugCount", deviceBugCount);
    }

    private boolean checkAuth(Map<String ,Object> params){
        List<Map<String, Object>> roleLists = srvUserRoleService.getRoleListByUserId(params);
        params.put("url","/equipmonitor/toManage.action");
        List<Map<String, Object>> maps = srvAuthService.queryAuthListByCondition(params);
        String authId = null;
        if(maps.size() > 0){
            Map<String, Object> map = maps.get(0);
            authId = MapUtils.getString(map, "id");
        }
        for (Map<String, Object> roleList : roleLists){
            String menus = MapUtils.getString(roleList,"menus");
            if(menus.contains(authId)){
                return true;
            }
        }
        return false;
    }
}
