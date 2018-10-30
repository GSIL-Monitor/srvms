package com.wgb.service.impl.srv;

import com.alibaba.fastjson.JSON;
import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.urms.admin.ApiBranchService;
import com.wgb.service.dubbo.urms.admin.ApiRechargeOrderService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class SrvShopServiceImpl implements SrvShopService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.srv.SrvShopServiceImpl.";

    public static final String EFFECTIVE_STORE = "effectiveStore"; // 缴费门店
    public static final String INVALID_STORE = "invalidStore"; // 未缴费门店
    public static final String TOTAL_STORE = "totalStore"; // 总门店
    public static final String MATURITY_STORE = "maturityStore"; // 到期门店
    public static final String PAYMENT_BRANCH = "paymentBranch"; // 付费门店
    public static final String NO_PAYMENT_BRANCH = "noPaymentBranch";// 未付费门店
    public static final String TOTAL_STORE_FOR_DATE = "totalStoreForDate"; // 指定新建门店总数

    private static final Integer LOSS_OF_DAYS = 45; // 默认流失天数

    protected final Logger logger = LoggerFactory.getLogger(SrvShopServiceImpl.class);

    @Autowired
    private CommonDalClient dal;

    @Autowired
    private ApiShopService apiShopService;

    @Autowired
    private ApiBranchService apiBranchService;

    @Autowired
    private ApiRechargeOrderService apiRechargeOrderService;

    @Override
    public Map<String, Object> getShopFollowInfo(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getShopFollowInfo", params);
    }

    @Override
    public void addSrvShop(Map<String, Object> params) {
        dal.getDalClient().execute(NAMESPACE + "addSrvShop", params);
    }

    @Override
    public Map<String, Object> getShopCountData(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getShopCountData", params);
    }

    /**
     * 获取首页商户环比增长率
     *
     * @param params
     * @return
     */
    @Override
    public Map<String, Object> getChainGrowthRate(Map<String, Object> params) {
        Map<String, Object> data = new HashMap<String, Object>();
        String newtime = MapUtils.getString(params, "newtime");
        int newshopCount = dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "getChainGrowthRate", params, Integer.class);
        //本周/本月商户增长数
        int thisTimeNewShop = 0;
        if (newtime.equals("thisweek")) {
            thisTimeNewShop = dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "getChainGrowthRateThisWeek", params, Integer.class);

        } else if (newtime.equals("thismonth")) {
            thisTimeNewShop = dal.getReadOnlyDalClient().queryForObject(NAMESPACE + "getChainGrowthRateThisMonth", params, Integer.class);

        } else {
            throw new ServiceException(ServiceException.OPER_ERROR);
        }
        //计算增长率  本周/本月除以总量后转double,乘100后向上取整后转int,页面展示不需要展示小数
        data.put("chainGrowthRate", (int) Math.ceil((double) thisTimeNewShop / newshopCount * 100));
        data.put("newshopCount", newshopCount);
        data.put("thisTimeNewShop", thisTimeNewShop);
        return data;
    }

    @Override
    public List<Map<String, Object>> queryShopCodeByServiceCode(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "queryShopCodeByServiceCode", params);
    }

    public Map<String, Integer> queryBranchCountByShopCode(List<Map<String, Object>> shopCode) {
        Map<String, Integer> result = new HashMap<>();
        int effectiveStore = 0;
        int invalidStore = 0;
        int totalStore = 0;
        try {
            // 查询当前未续费门店数量
            ZLRpcResult rpcResult = apiShopService.queryBranchCountByShopCode(shopCode);
            List<Map<String, Object>> branchCounts = (List<Map<String, Object>>) rpcResult.getData();
            if (CollectionUtils.isNotEmpty(branchCounts)) {
                for (Map<String, Object> branchCount : branchCounts) {
                    effectiveStore = Integer.parseInt(branchCount.get(EFFECTIVE_STORE).toString()) + effectiveStore;
                    invalidStore = Integer.parseInt(branchCount.get(INVALID_STORE).toString()) + invalidStore;
                }
                totalStore = invalidStore + effectiveStore;
                result.put(EFFECTIVE_STORE, effectiveStore);
                result.put(INVALID_STORE, invalidStore);
                result.put(TOTAL_STORE, totalStore);
            }
        } catch (Exception e) {
            logger.info("HomeController.index 查询信息异常！", e);
        }
        return result;
    }


    public int queryMaturityStoreNumsByDaysAndShopCode(Integer maturityDaysValue, List<Map<String, Object>> shopCodeList) {
        int maturityStore = 0;
        // 根据店铺Code查询即将到期的门店数量
        List<Map<String, Object>> maturityStoreNums = queryMaturityNumStoreByDaysAndShopCodes(maturityDaysValue, shopCodeList);
        // 遍历，获取每个门店的即将到期门店数量，求和
        if (CollectionUtils.isNotEmpty(maturityStoreNums)) {
            for (Map<String, Object> maturityStoreNum : maturityStoreNums) {
                Set<String> keySet = maturityStoreNum.keySet();
                for (String key : keySet) {
                    if (!"shopCode".equalsIgnoreCase(key)) {
                        maturityStore = Integer.parseInt(maturityStoreNum.get(key).toString()) + maturityStore;
                    }
                }
            }
        }
        return maturityStore;
    }

    public List<Map<String, Object>> queryMaturityNumStoreByDaysAndShopCodes(Integer maturityDaysValue, List<Map<String, Object>> shopCodeList) {
        List<Map<String, Object>> result = null;
        try {
            ZLRpcResult rpcResult = apiShopService.queryMaturityNumStoreByDaysAndShopCodes(maturityDaysValue, shopCodeList);
            result = rpcResult.getList();
        } catch (Exception e) {
            logger.info("SrvShopServiceImpl.queryMaturityNumStoreByDaysAndShopCodes 查询店铺到期门店数异常!", e);
        }
        return result;
    }

    @Override
    public Map<String, Object> getSrvShopInfo(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getSrvShopInfo", params);
    }

    public int getExpireBranchCount(Map<String, Object> params) {
        ZLRpcResult rpcResult = null;
        try {
            logger.info(String.format("查询即将到期商户数量参数:%s!", params.toString()));
            rpcResult = apiShopService.getExpireBranchCount(params);
            if (rpcResult.success()) {
                Integer data = Integer.parseInt(rpcResult.getData().toString());
                logger.info(String.format("查询到期商户数量结果:%s", data));
                return data;
            } else {
                logger.error(String.format("调用RPC查询到期商户失败!错误代码：%s", rpcResult.getErrorCode()));
                return 0;
            }
        } catch (Exception e) {
            logger.error(String.format("调用RPC查询到期商户异常!"), e);
            throw new RuntimeException(String.format("调用RPC查询到期商户异常!"), e);
        }
    }

    public Map<String, Object> getStoreCount(Map<String, Object> params) {
        Map<String, Object> resutl = new HashMap<>();
        Map<String, Object> newStoreCount = getNewStoreCount(params);
        resutl.put("newStore", newStoreCount);
        Map<String, Object> lossStoreCount = getLossStoreCount(params);
        resutl.put("lossStore", lossStoreCount);
        return resutl;
    }


    public Map<String, Object> getNewStoreCount(Map<String, Object> params) {
        ZLRpcResult rpcResult = null;
        try {
            logger.info(String.format("查询指定时间新增用户:%s!", params.toString()));
            rpcResult = apiShopService.getNewStoreCount(params);
            if (rpcResult.success()) {
                Map<String, Object> resultData = (Map<String, Object>) rpcResult.getData();
                logger.info(String.format("查询指定时间新增用户信息:%s", resultData.toString()));
                return resultData;
            } else {
                logger.error(String.format("查询指定时间新增用户失败!错误代码：%s", rpcResult.getErrorCode()));
                return null;
            }
        } catch (Exception e) {
            logger.error(String.format("查询指定时间新增用户异常!"), e);
            throw new RuntimeException(String.format("查询指定时间新增用户异常!"), e);
        }
    }

    public Map<String, Object> getShopFollowInfoByFormTable(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getShopFollowInfoByFormTable", params);
    }

    private Map<String, Object> getLossStoreCount(Map<String, Object> params) {
        ZLRpcResult rpcResult = null;
        try {
            logger.info(String.format("查询流失门店参数:%s!", params.toString()));
            rpcResult = apiBranchService.queryBranchRecharge(params);
            if (rpcResult.success()) {
                Map<String, Object> resultData = (Map<String, Object>) rpcResult.getData();
                logger.info(String.format("查询流失门店参数:%s", resultData.toString()));
                return resultData;
            } else {
                logger.error(String.format("查询流失门店失败!错误代码：%s", rpcResult.getErrorCode()));
                return null;
            }
        } catch (Exception e) {
            logger.error(String.format("查询流失门店异常!"), e);
            throw new RuntimeException(String.format("查询流失门店异常!"), e);
        }
    }

    @Override
    public List<Map<String, Object>> getSrvShopList(Map<String, Object> params) {
        return dal.getDalClient().queryForList(NAMESPACE + "getSrvShopList", params);
    }

    public Map<String, Object> queryNewBranchNumsBuyServerCode(Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        Integer paymentBranch = 0;
        Integer noPaymentBranch = 0;
        try {
            ZLRpcResult rpcResult = apiShopService.queryNewBranchNumsBuyServerCode(params);
            List<Map<String, Object>> rpcResultData = (List<Map<String, Object>>) rpcResult.getData();
            if (CollectionUtils.isNotEmpty(rpcResultData)) {
                for (Map<String, Object> branchNums : rpcResultData) {
                    noPaymentBranch += MapUtils.getInteger(branchNums, SrvShopServiceImpl.NO_PAYMENT_BRANCH);
                    paymentBranch += MapUtils.getInteger(branchNums, SrvShopServiceImpl.PAYMENT_BRANCH);
                }
            }
            result.put(SrvShopServiceImpl.NO_PAYMENT_BRANCH, noPaymentBranch);
            result.put(SrvShopServiceImpl.PAYMENT_BRANCH, paymentBranch);
        } catch (Exception e) {
            logger.info("SrvShopServiceImpl.queryMaturityNumStoreByDaysAndShopCodes 查询店铺到期门店数异常!", e);
        }
        return result;
    }

    public Page<?> queryShopAndBranchNums(Map<String, Object> params) {
        ZLRpcResult result = null;
        try {
            result = apiShopService.queryShopAndBranchNums(params);
            return (Page<?>) result.getData();
        } catch (Exception e) {
            logger.info("SrvShopServiceImpl.queryShopAndBranchNums 调用RPC查询店铺信息异常!", e);
        }
        return null;
    }

    public List<Map<String, Object>> queryBranchInfoByShopCode(Map<String, Object> params) {
        ZLRpcResult result = null;
        try {
            result = apiShopService.queryBranchInfoByShopCode(params);
            logger.info(JSON.toJSONString(result.getList()));
            return result.getList();
        } catch (Exception e) {
            logger.info("SrvShopServiceImpl.queryBranchInfoByShopCode 调用RPC查询门店信息异常!");
        }
        return null;
    }

    public List<Map<String, Object>> queryProductInfo(Map<String, Object> params) {
        ZLRpcResult result = null;
        try {
            result = apiShopService.queryProductInfo(params);
            return result.getList();
        } catch (Exception e) {
            logger.info("SrvShopServiceImpl.queryBranchInfoByShopCode 调用RPC查询门店信息异常!");
        }
        return null;
    }
    public void updateShopfollow(Map<String, Object> params) {
        List<Map<String, Object>> saveParams = new ArrayList<>();
        String ids = MapUtils.getString(params, "ids", "");
        if (StringUtils.isNotEmpty(ids)) {
            String servercode = MapUtils.getString(params, "servercode");
            String shopcodes = MapUtils.getString(params, "shopcodes");
            String loginuserid = MapUtils.getString(params, "loginuserid");
            String followremark = MapUtils.getString(params, "followremark");
            String followlabel = MapUtils.getString(params, "followlabel");
            String[] idArr = ids.split(",");
            String[] shopcodeArr = shopcodes.split(",");
            //循环更新商户标注数据
            for (int index = 0; index < idArr.length; index++) {
                String id = idArr[index];
                String shopcode = shopcodeArr[index];
                Map<String, Object> p1 = new HashMap<String, Object>();
                p1.put("id", id);
                p1.put("shopcode", shopcode);
                p1.put("servercode", servercode);
                p1.put("loginuserid", loginuserid);
                p1.put("followremark", followremark);
                p1.put("followlabel", followlabel);
                saveParams.add(p1);
            }
        }
        dal.getDalClient().batchUpdate(NAMESPACE + "updateShopfollow", saveParams.toArray(new Map[saveParams.size()]));
    }

    @Override
    public void addRegShop(Map<String, Object> params) {
        //同步注册指令到urms系统
        ZLRpcResult rpcResult = null;
        try {
            rpcResult = apiShopService.srvRegShop(params);
        } catch (Exception ex) {
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        String errmsg = MapUtils.getString(rpcResult.getMap(), "errmsg");
        if (StringUtils.isNotEmpty(errmsg)) {
            throw new ServiceException(errmsg);
        }
        String shopcode = MapUtils.getString(rpcResult.getMap(), "shopcode");
        if (StringUtils.isNotEmpty(shopcode)) {
            params.put("shopcode", MapUtils.getString(rpcResult.getMap(), "shopcode"));
            //保存商户数据
            addSrvShop(params);
        } else {
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
    }

    /**
     * 服务商为商户注册账号
     *
     * @param params
     */
    @Override
    public void insertServerShop(Map<String, Object> params) {
        String servercode = MapUtils.getString(params, "servercode", "");
        String shopcode = MapUtils.getString(params, "shopcode", "");
        if(StringUtils.isNotEmpty(servercode) && StringUtils.isNotEmpty(shopcode)){
            dal.getDalClient().execute(NAMESPACE + "insertServerShop", params);
        }
    }

    @Override
    public Map<String, Object> getServerCodeByCode(Map<String, Object> params) {
        Map<String,Object> resultMap =  new HashMap<String,Object>();
        String regservercode = MapUtils.getString(params, "regservercode", "");
        if(StringUtils.isNotEmpty(regservercode)){
            resultMap = dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getServerCodeByCode", params);
        }
        return resultMap;
    }

    public Page<?> querySrvShopPage(Map<String, Object> params) {
        String followlabel = MapUtils.getString(params, "followlabel");
        //获取关联商户数据
        ZLRpcResult rpcResult = null;
        try {
            rpcResult = apiShopService.querySrvmsShopPageList(params);
        } catch (Exception ex) {
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        Page<Map<String, Object>> pageInfo = (Page<Map<String, Object>>) rpcResult.getData();
        //商户清单
        if (pageInfo != null && CollectionUtils.isNotEmpty(pageInfo.getList())) {

            //商品清单
            List<Map<String, Object>> dataList = pageInfo.getList();
            List<Map<String, Object>> screenList = new ArrayList<>();
            //根据标注状态进行查询
            if (StringUtils.isNotEmpty(followlabel)) {
                setShopFollowFormTable(dataList);
                //获取页面需要查询的标注状态
                //筛选标注状态
                screenList = setScreenShopFolloew(dataList, followlabel);
                pageInfo.setList(screenList);
            } else {
                //给商户添加商品字段,标注字段
                setShopFollowFormTable(dataList);
                pageInfo.setList(dataList);
            }
        }
        return pageInfo;
    }

    public Map<String, Object> queryShopDetail(Map<String, Object> params) {
        Map<String ,Object> queryParams = new HashMap<>();
        queryParams.put("shopcode" ,MapUtils.getString(params ,"shopcode" ,""));
        queryParams.put("servercode" ,MapUtils.getString(params ,"servercode" ,""));
        ZLRpcResult rpcResult = apiShopService.getShopInfo(queryParams);
        Map<String, Object> shopInfo = rpcResult.getMap();
        Map<String, Object> shopMap = getShopFollowInfo(params);
        shopInfo.put("followremark", MapUtils.getString(shopMap, "followremark", ""));
        shopInfo.put("followlabel", MapUtils.getString(shopMap, "followlabel", ""));
        return shopInfo;
    }

    @Override
    public Page queryBranchList(Map<String, Object> params) {
        //获取关联商户门店 数据
        ZLRpcResult branchInfo = apiBranchService.queryBranchPageList(params);
        if ( null != branchInfo && branchInfo.success()){
            return (Page) branchInfo.getData();
        }
        throw new BusinessException(BusinessException.getExceptionBean("biz.dubbo.system"));
    }

    public List<Map<String, Object>> rechargeDetail(Map<String, Object> params) {
        //获取关联商户门店 数据
        ZLRpcResult rpcResult = apiRechargeOrderService.queryRechargeOrderList(params);
        List<Map<String, Object>> rechargeList = rpcResult.getList();
        return rechargeList;
    }

    /**
     * 筛选标注状态
     *
     * @param dataList
     * @param followlabel
     * @return
     */
    private List<Map<String, Object>> setScreenShopFolloew(List<Map<String, Object>> dataList, String followlabel) {
        //筛选list
        List<Map<String, Object>> screenList = new ArrayList<>();
        //遍历数据
        for (Map<String, Object> dataItem : dataList) {
            //从数据库查出标注信息
            String _followlabels = MapUtils.getString(dataItem, "followlabel");
            //根据查询数据格式化数据
            if (followlabel.equals(_followlabels)) {
                screenList.add(dataItem);
            }
        }
        return screenList;
    }

    /**
     * 给商户添加标注字段
     *
     * @param dataList
     */
    private void setShopFollow(List<Map<String, Object>> dataList) {
        //遍历list获取map参数
        for (Map<String, Object> dataItem : dataList) {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("shopcode", MapUtils.getString(dataItem, "shopcode"));
            params.put("servercode", MapUtils.getString(dataItem, "servercode"));

            //获取商户标注信息
            Map<String, Object> shopMap = getShopFollowInfo(params);
            dataItem.put("id", MapUtils.getString(shopMap, "id", ""));
            dataItem.put("followremark", MapUtils.getString(shopMap, "followremark", ""));
            dataItem.put("followlabel", MapUtils.getString(shopMap, "followlabel", ""));
        }
    }

    /**
     * 给商户添加标注字段
     *
     * @param dataList
     */
    private void setShopFollowFormTable(List<Map<String, Object>> dataList) {
        //遍历list获取map参数
        for (Map<String, Object> dataItem : dataList) {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("shopcode", MapUtils.getString(dataItem, "shopcode"));
            params.put("servercode", MapUtils.getString(dataItem, "servercode"));

            //获取商户标注信息
            Map<String, Object> shopMap = getShopFollowInfoByFormTable(params);
            dataItem.put("id", MapUtils.getString(shopMap, "id", ""));
            dataItem.put("followremark", MapUtils.getString(shopMap, "followremark", "").replaceAll("\n" ,"<br>"));
            dataItem.put("followremarkdetail",MapUtils.getString(shopMap, "followremarkdetail", "").replaceAll("\n" ,"<br>"));
            dataItem.put("followlabel", MapUtils.getString(shopMap, "followlabel", ""));
        }
    }
}
