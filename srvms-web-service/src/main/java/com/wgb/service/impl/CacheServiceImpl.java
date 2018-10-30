package com.wgb.service.impl;

import com.wgb.cache.CacheEnum;
import com.wgb.cache.RedisFactory;
import com.wgb.cache.CacheType;
import com.wgb.cache.CacheTypeEnum;
import com.wgb.util.CacheConstant;
import com.wgb.service.CacheDataService;
import com.wgb.service.CacheService;
import com.wgb.util.CommonConfig;
import com.wgb.exception.ServiceException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wgb on 2016/8/23.
 */
@Service
public class CacheServiceImpl implements CacheService, ApplicationContextAware {

    protected final Logger logger = LoggerFactory.getLogger(getClass());
    private ApplicationContext applicationContext;

    /**
     * 分库缓存KEY字段连接符
     */
    private static final String SHARD_CACHE_SPLIT = "_";

    /**
     * 获取缓存List
     * 当缓存存在时,直接从缓存中读取
     * 当缓存不存在时,从数据库中读取,然后再放到缓存中
     *
     * @param key
     * @param args
     * @return
     */
    @Override
    public List<Map<String, Object>> getCacheList(String key, String... args) {

        if (StringUtils.isEmpty(key)) {
            throw new ServiceException(ServiceException.PARAM_ERROR);
        }

        //分库key
        String _key = generateKey(key, args);
        //从数据库中查询数据
        CacheType cacheType = CacheConstant.getCacheType(key);
        //结果集
        List<Map<String, Object>> resultList = null;

        // 首先从Cache中获取
        try {
            resultList = RedisFactory.getRedisClient(cacheType.getCacheEntryEnum()).getListFromJedis(_key);
        } catch (Exception e) {
            logger.error("从Cache中获取List失败,key为：" + _key, e);
        }

        if (CollectionUtils.isEmpty(resultList)) {
            //从数据库中查询数据
            CacheDataService cacheDataService = (CacheDataService) applicationContext.getBean(cacheType.getBeanName());
            resultList = cacheDataService.getCacheList(getParamMap(args));
            try {
                // 将查询到的数据列表放入Cache中
                RedisFactory.getRedisClient(cacheType.getCacheEntryEnum()).setListToJedis(resultList, _key);
            } catch (Exception e) {
                logger.error("将查询到的数据List放入Cache中失败", e);
            }
        }
        return resultList;
    }

    /**
     * 获取缓存Map
     * 当缓存存在时,直接从缓存中读取
     * 当缓存不存在时,从数据库中读取,然后再放到缓存中
     *
     * @param key
     * @param args
     * @return
     */
    @Override
    public Map<String, Object> getCacheMap(String key, String... args) {

        if (StringUtils.isEmpty(key)) {
            throw new ServiceException(ServiceException.PARAM_ERROR);
        }

        //分库key
        String _key = generateKey(key, args);
        //从数据库中查询数据
        CacheType cacheType = CacheConstant.getCacheType(key);

        //结果集
        Map<String, Object> resultMap = null;

        // 首先从Cache中获取
        try {
            resultMap = RedisFactory.getRedisClient(cacheType.getCacheEntryEnum()).getMapFromJedis(_key);
        } catch (Exception e) {
            logger.error("从Cache中获取Map失败,key为：" + _key, e);
        }

        if (MapUtils.isEmpty(resultMap)) {

            CacheDataService cacheDataService = (CacheDataService) applicationContext.getBean(cacheType.getBeanName());
            resultMap = cacheDataService.getCacheMap(getParamMap(args));

            try {
                // 将查询到的数据列表放入Cache中
                RedisFactory.getRedisClient(cacheType.getCacheEntryEnum()).setMapToJedis(resultMap, _key);
            } catch (Exception e) {
                logger.error("将查询到的数据Map放入Cache中失败", e);
            }
        }

        return resultMap;
    }

    /**
     * 获取一级、二级、三级缓存参数Map
     *
     * @param args
     * @return
     */
    private Map<String, Object> getParamMap(String... args) {
        //默认为一级缓存
        Map<String, Object> result = new HashMap<String, Object>();

        //二级缓存
        if (args.length == 1) {
            String shopcode = args[0];
            result.put("shopcode", shopcode);
        }
        //三级缓存
        else if (args.length == 2) {
            String shopcode = args[0];
            String branchcode = args[1];

            result.put("shopcode", shopcode);
            result.put("branchcode", branchcode);
        }
        return result;
    }

    @Override
    public void updateAllCache(String... args) {

        if (CacheConstant.CACHE_LIST.size() == 0) {
            return;
        }

        CacheTypeEnum cacheTypeEnum = null;

        //系统缓存
        if (args.length == 0) {
            cacheTypeEnum = CacheTypeEnum.SYSTEM;
        }
        //商户缓存
        else if (args.length == 1) {
            cacheTypeEnum = CacheTypeEnum.SHOP;
        }
        //门店缓存
        else if (args.length == 2) {
            cacheTypeEnum = CacheTypeEnum.BRANCH;
        }

        for (CacheType cacheType : CacheConstant.CACHE_LIST) {
            if (cacheType.getCacheTypeEnum() == cacheTypeEnum) {
                updateCache(cacheType.getKey(), args);
            }
        }
    }

    @Override
    public void updateCache(String key, String... args) {

        if (StringUtils.isEmpty(key)) {
            throw new ServiceException(ServiceException.PARAM_ERROR);
        }

        //分库key
        String _key = generateKey(key, args);
        //从数据库中查询数据
        CacheType cacheType = CacheConstant.getCacheType(key);

        //缓存数据接口
        CacheDataService cacheDataService = (CacheDataService) applicationContext.getBean(cacheType.getBeanName());

        if (cacheType.getCacheEnum().equals(CacheEnum.LIST)) {
            RedisFactory.getRedisClient(cacheType.getCacheEntryEnum()).setListToJedis(cacheDataService.getCacheList(getParamMap(args)), _key);
        } else {
            RedisFactory.getRedisClient(cacheType.getCacheEntryEnum()).setMapToJedis(cacheDataService.getCacheMap(getParamMap(args)), _key);
        }
    }

    /**
     * 根据参数生成缓存key
     *
     * @param key
     * @param args
     * @return
     */
    private String generateKey(String key, String... args) {
        //分库key
        String _key = key;

        //从数据库中查询数据
        CacheType cacheType = CacheConstant.getCacheType(key);
        //如果是商户二级缓存
        if (cacheType.getCacheTypeEnum() == CacheTypeEnum.SHOP) {
            if (args.length != 1) {
                throw new ServiceException(ServiceException.PARAM_ERROR);
            }

            String shopcode = args[0];
            if (StringUtils.isEmpty(shopcode)) {
                throw new ServiceException(ServiceException.PARAM_ERROR);
            }

            //分库key
            _key = key + SHARD_CACHE_SPLIT + shopcode;
        }
        //如果是门店三级缓存
        else if (cacheType.getCacheTypeEnum() == CacheTypeEnum.BRANCH) {

            if (args.length != 2) {
                throw new ServiceException(ServiceException.PARAM_ERROR);
            }
            String shopcode = args[0];
            String branchcode = args[1];

            if (StringUtils.isEmpty(shopcode) || StringUtils.isEmpty(branchcode)) {
                throw new ServiceException(ServiceException.PARAM_ERROR);
            }

            //分库key
            _key = key + SHARD_CACHE_SPLIT + shopcode + SHARD_CACHE_SPLIT + branchcode;
        }
        return _key;
    }

    @Override
    public void setYzm(String yzm, String mobile, String type) {
        RedisFactory.getDefaultClient().set(new StringBuilder(type).append(mobile).toString(), yzm, 300);
    }

    @Override
    public String getYzm(String mobile, String type) {
        return RedisFactory.getDefaultClient().get(new StringBuilder(type).append(mobile).toString(), -1);
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}