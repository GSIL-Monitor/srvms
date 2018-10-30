package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.service.srv.SrvMenuService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class SrvMenuServiceImpl implements SrvMenuService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.SrvMenuServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Autowired
    private SrvUserService srvUserService;

    public List<Map<String, Object>> getRemoteMenuList(String account) {
        List<Map<String, Object>> menuList = getMenuList(account);
        return menuList;
    }

    public List<Map<String, Object>> getMenuList(String account) {

        Map<String, Object> p1 = new HashMap<String, Object>();
        p1.put("account", account);
        Map<String, Object> userInfo = srvUserService.getLoginUser(p1);
        if (MapUtils.isEmpty(userInfo)) {
            return null;
        }
        String userid = MapUtils.getString(userInfo, "id", "");
        List<Map<String, Object>> menuList = getMenuByUserId(userid);
        List<Map<String, Object>> result = formatMenus(menuList);
        return result;
    }

    private List<Map<String, Object>> formatMenus(List<Map<String, Object>> menuList) {
        List<Map<String, Object>> result = new ArrayList<>();
        Map<String , Map<String, Object>> menu = new HashMap<>();

        for (Map<String ,Object> menuMap : menuList){  // 找出所有的父类菜单
            String pid = MapUtils.getString(menuMap, "pid");
            if ("-1".equalsIgnoreCase(pid) && !menu.containsKey(pid)){
                // 父类菜单
                Map<String ,Object> pmenu = new HashMap<>();
                pmenu.put("key" ,MapUtils.getString(menuMap ,"id"));
                pmenu.put("title" ,MapUtils.getString(menuMap ,"name"));
                pmenu.put("icon" ,MapUtils.getString(menuMap ,"icon"));
                pmenu.put("ordernum" ,MapUtils.getString(menuMap ,"ordernum"));
                pmenu.put("url" ,MapUtils.getString(menuMap ,"url"));
                pmenu.put("children" ,new ArrayList<Map<String ,Object>>());
                menu.put(MapUtils.getString(menuMap ,"id") ,pmenu);
                continue;
            }else if("-1".equalsIgnoreCase(pid) && menu.containsKey(pid)){  // 父类菜单，已经存在了
                String id = MapUtils.getString(menuMap, "id");
                Map<String, Object> pmenu = menu.get(id);
                pmenu.put("key" ,MapUtils.getString(menuMap ,"id"));
                pmenu.put("title" ,MapUtils.getString(menuMap ,"name"));
                pmenu.put("icon" ,MapUtils.getString(menuMap ,"icon"));
                pmenu.put("ordernum" ,MapUtils.getString(menuMap ,"ordernum"));
                pmenu.put("url" ,MapUtils.getString(menuMap ,"url"));
                menu.put(MapUtils.getString(menuMap ,"id") ,pmenu);
                continue;
            }else if(!"-1".equalsIgnoreCase(pid) && !menu.containsKey(pid)){ // 普通的菜单,但是没有
                Map<String ,Object> pmenu = new HashMap<>(); // 父类菜单
                List<Map<String ,Object>> childrenList = new ArrayList<>();
                Map<String ,Object> cmenu = new HashMap<>(); // 子类菜单
                cmenu.put("key" ,MapUtils.getString(menuMap ,"id"));
                cmenu.put("title" ,MapUtils.getString(menuMap ,"name"));
                cmenu.put("ordernum" ,MapUtils.getString(menuMap ,"ordernum"));
                cmenu.put("url" ,MapUtils.getString(menuMap ,"url"));
                childrenList.add(cmenu);
                pmenu.put("children" ,childrenList);
                menu.put(MapUtils.getString(menuMap ,"pid") ,pmenu);
                continue;
            }else { // 普通的菜单，已经有了
                Map<String, Object> pmenu = menu.get(pid);
                List<Map<String ,Object>> childrenList = (List<Map<String ,Object>>)pmenu.get("children");
                Map<String ,Object> cmenu = new HashMap<>(); // 子类菜单
                cmenu.put("key" ,MapUtils.getString(menuMap ,"id"));
                cmenu.put("title" ,MapUtils.getString(menuMap ,"name"));
                cmenu.put("ordernum" ,MapUtils.getString(menuMap ,"ordernum"));
                cmenu.put("url" ,MapUtils.getString(menuMap ,"url"));
                childrenList.add(cmenu);
                continue;
            }
        }
        for (Map.Entry<String , Map<String, Object>> entry : menu.entrySet()){
            String key = entry.getKey();
            Map<String, Object> value = entry.getValue();
            Object id = value.get("key");
            if (StringUtils.isNotBlank(entry.getKey()) && id != null){
                result.add(value);
                List<Map<String ,Object>> children = (List<Map<String ,Object>>)value.get("children");
                Collections.sort(children, new IntegerComparator()); // 排序
            }
        }
        //菜单按照ordernum排序
        Collections.sort(result, new IntegerComparator());
        return result;
    }


    public List<Map<String, Object>> getMenuByUserId(String userid) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("userid", userid);
        List<Map<String, Object>> menusList = dal.getReadOnlyDalClient().queryForList(NAMESPACE + "getMenuByUserId", params);
        if (CollectionUtils.isNotEmpty(menusList)) {
            List<String> menuIds = new ArrayList<String>();
            for (Map<String, Object> menusObj : menusList) {
                String menus = MapUtils.getString(menusObj, "menus", "");
                String[] menuArr = menus.split(",");
                for (String menuId : menuArr) {
                    if (StringUtils.isNotEmpty(menuId) && !menuIds.contains(menuId)) {
                        menuIds.add(menuId);
                    }
                }
            }

            //获取所有菜单列表
            List<Map<String, Object>> menuList = dal.getReadOnlyDalClient().queryForList(NAMESPACE + "getMenuList", params);

            List<String> resultIds = new ArrayList<String>();
            List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

            //初始化菜单Map
            Map<String, Map<String, Object>> menuMap = new HashMap<String, Map<String, Object>>();
            for (Map<String, Object> menu : menuList) {
                menuMap.put(MapUtils.getString(menu, "id"), menu);
            }

            //遍历权限菜单ids
            for (String menuId : menuIds) {

                //获取菜单及其所有父节点
                String menuid = menuId;
                while (StringUtils.isNotEmpty(menuid) && !menuid.equals(Contants.NODE_PARENT_PID)) {

                    Map<String, Object> menu = menuMap.get(menuid);

                    if (!resultIds.contains(menuid)) {
                        resultList.add(menu);
                        resultIds.add(menuid);
                    }

                    menuid = MapUtils.getString(menu, "pid");
                }
            }



            return resultList;
        }
        return null;
    }

    // 自定义比较器：按书出版时间来排序
    static class IntegerComparator implements Comparator {
        public int compare(Object object1, Object object2) {// 实现接口中的方法
            Map<String, Object> p1 = (Map<String, Object>) object1; // 强制转换
            Map<String, Object> p2 = (Map<String, Object>) object2;
            Integer ordernum1 = MapUtils.getInteger(p1, "ordernum", 0);
            Integer ordernum2 = MapUtils.getInteger(p2, "ordernum", 0);
            return ordernum1.compareTo(ordernum2);
        }
    }
}
