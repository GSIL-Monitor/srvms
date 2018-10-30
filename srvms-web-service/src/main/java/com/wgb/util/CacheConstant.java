package com.wgb.util;

import com.wgb.cache.CacheEnum;
import com.wgb.cache.CacheType;
import com.wgb.cache.CacheTypeEnum;
import org.apache.commons.collections.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wgb on 2016/8/23.
 */
public class CacheConstant {
    /**
     * 系统通用数据缓存
     */
    public static List<CacheType> CACHE_LIST = new ArrayList<CacheType>();
    public static final String CACHE_PORTAL_MENU_LIST = "PortalMenuList";

    /**
     * 商户通用该数据缓存
     */

    /**
     * 门店通用数据缓存
     */

    public static final String CACHE_SHOP_ACTTYPE_LIST = "ActTypeList";
    public static final String CACHE_SHOP_BRANCH_LIST = "BranchList";


    static {
        /**
         * 系统通用数据缓存初始化
         */
        //菜单列表

        /**
         * 商户通用该数据缓存初始化
         */
        CACHE_LIST.add(new CacheType(CACHE_SHOP_ACTTYPE_LIST, CacheEnum.LIST, "mediaTypeServiceImpl", CacheTypeEnum.SHOP));

        /**
         * 门店通用数据缓存初始化
         */
    }

    public static CacheType getCacheType(String key) {
        if (CollectionUtils.isNotEmpty(CACHE_LIST)) {
            for (CacheType cacheType : CACHE_LIST) {
                if (cacheType.getKey().equals(key)) {
                    return cacheType;
                }
            }
        }

        return null;
    }
}
