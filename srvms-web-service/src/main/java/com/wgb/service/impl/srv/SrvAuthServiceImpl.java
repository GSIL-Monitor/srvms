package com.wgb.service.impl.srv;

import com.wgb.dao.CommonDalClient;
import com.wgb.service.RoleService;
import com.wgb.service.srv.SrvAuthService;
import com.wgb.util.CommonUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SrvAuthServiceImpl implements SrvAuthService {

    private static final String NAME_SPACE = "shardName.com.wgb.service.impl.srv.SrvAuthServiceImpl.";

    @Autowired
    private CommonDalClient dalClient;

    @Autowired
    private RoleService roleService;


    public List<Map<String, Object>> queryAuthListByCondition(Map<String, Object> params) {
        // 查询当前角色
        Map<String, Object> role = roleService.getRole(params);
        // 查询所有的权限
        List<Map<String, Object>> menuList = dalClient.getReadOnlyDalClient().queryForList(NAME_SPACE + "queryAuthListByCondition", params);
        // 获取权限
        String[] menuArr = MapUtils.getString(role, "menus", "").split(",");
        // 设置权限中当前角色已经拥有的权限
        setMenuChecked(menuList, menuArr);
        // 设置权限树
        return  CommonUtil.getTreeList(menuList, "-1", "name");
    }

    public void updateAuthForRole(Map<String, Object> params) {
        roleService.updateRole(params);
    }

    /**
     * 根据用户角色菜单，设置菜单列表选中
     *
     * @param menuList
     * @param menuArr
     */
    private void setMenuChecked(List<Map<String, Object>> menuList, String[] menuArr) {
        if (CollectionUtils.isNotEmpty(menuList) && menuArr.length != 0) {
            for (Map<String, Object> menu : menuList) {
                for (String menuid : menuArr) {
                    if (MapUtils.getString(menu, "id").equals(menuid)) {
                        menu.put("checked", "1");
                        break;
                    }else {
                        menu.put("checked", "0");
                    }
                }
            }
        }
    }
}
