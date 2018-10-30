package com.wgb.service.impl.srv;

import com.wgb.cache.RedisFactory;
import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.sms.web.ApiSmsService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.srv.SrvAssociationShopService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import com.wgb.util.Validator;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
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

    @Autowired
    private ApiSmsService apiSmsService;



    @Override
    public String addAssociationInfo(Map<String, Object> params) {
        // 校验验证码
        String message = checkYzm(params);
        if (StringUtils.isNotBlank(message)){
            return message;
        }
        // 获取商户信息
        Map<String, Object> shopInfo = checkShopExist(params);
        Map<String, Object> srvShopInfo = srvShopService.getSrvShopInfo(params);
        // 设置关联商户信息
        Map<String, Object> associationInfo = setSaveAssociationInfo(shopInfo, srvShopInfo, params);
        updateAssociationShop(associationInfo);
        saveShopAndSrvRelation(associationInfo);
        return "";
    }

    private Map<String ,Object> setSaveAssociationInfo( Map<String, Object> shopInfo ,Map<String, Object> srvShopInfo ,Map<String, Object> params){
        Map<String, Object> associationInfo = new HashMap<String, Object>();
        // 获取店铺省市区
        String shoparea = getShopArea(params);
        associationInfo.put("servercode", MapUtils.getString(srvShopInfo, "servercode"));
        associationInfo.put("servername", MapUtils.getString(srvShopInfo, "servername"));
        associationInfo.put("serverarea", MapUtils.getString(srvShopInfo, "area"));
        associationInfo.put("servertel", MapUtils.getString(srvShopInfo, "tel"));
        associationInfo.put("serverusername", MapUtils.getString(srvShopInfo, "contact"));
        associationInfo.put("shopname", MapUtils.getString(shopInfo, "shopname"));
        associationInfo.put("shopcode", MapUtils.getString(shopInfo, "shopcode"));
        associationInfo.put("shopusername", MapUtils.getString(shopInfo, "contact"));
        associationInfo.put("shoptel", MapUtils.getString(shopInfo, "tel"));
        associationInfo.put("shopindustryid", MapUtils.getString(shopInfo, "industryid"));
        associationInfo.put("shopindustryname", MapUtils.getString(shopInfo, "industryname"));
        associationInfo.put("loginuserid", MapUtils.getString(params, "loginuserid"));
        associationInfo.put("shoparea", shoparea);
        return associationInfo;
    }


    private String checkYzm(Map<String, Object> params) {
        Map<String ,Object> queryParams = new HashMap<>();
        queryParams.put("keyword" ,MapUtils.getString(params ,"keyword" ,""));
        queryParams.put("shopcode" ,MapUtils.getString(params ,"shopcode" ,""));
        //获取商户数据
        ZLRpcResult rpcResult = apiShopService.getShopInfo(queryParams);
        String account = MapUtils.getString(rpcResult.getMap(), "tel");
        if (StringUtils.isEmpty(account)) {
            return "该商户没有保存手机号!!!";
        }
        String yzm = MapUtils.getString(params, "yzm");
        if (StringUtils.isEmpty(yzm)) {
            return "验证码必须填写";
        }

        if (StringUtils.isEmpty(account)) {
            return "账号必须输入";
        }

        String mobileKey = Contants.SMS_AAS_TYPE + account;
        String _yzm = RedisFactory.getDefaultClient().get(mobileKey);
        if (StringUtils.isNotEmpty(_yzm) && yzm.equals(_yzm)) {
            return "";
        }
        return "验证码输入错误";
    }


    private String getShopArea(Map<String ,Object> params){
        //现在商户区域没有必输
        String provincename = MapUtils.getString(params, "provincename");
        String cityname = MapUtils.getString(params, "cityname");
        String districtname = MapUtils.getString(params, "districtname");
        String shoparea = "";
        if (!"请选择".equals(cityname) ) {
            shoparea = provincename + "-" + cityname + "-" + districtname;
        }
        return shoparea;
    }

    /**
     * @param params
     */
    private void updateAssociationShop(Map<String ,Object> params){
        Map<String ,Object> updateParams = new HashMap<>();
        updateParams.put("servercode" , MapUtils.getString(params ,"servercode"));
        updateParams.put("servername" , MapUtils.getString(params ,"servername"));
        updateParams.put("shopcode" , MapUtils.getString(params ,"shopcode"));
        apiShopService.updateAssociationShop(params);
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

    @Override
    public Page<?> queryPageInfo(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryPageInfo", params);
    }

    @Override
    public List<Map<String, Object>> getIndustryNameList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForList(NAMESPACE + "getIndustryNameList", params);
    }

    @Override
    public Map<String, Object> getShopInfo(Map<String, Object> params) {
        Map<String, Object> shopInfo = checkShopExist(params);
        return  formatShopInfo(shopInfo);
    }

    @Override
    public String sendYzm(Map<String, Object> params) {
        //获取商户数据
        Map<String ,Object> queryParams = new HashMap<>();
        queryParams.put("keyword" ,MapUtils.getString(params ,"keyword" ,""));
        queryParams.put("shopcode" ,MapUtils.getString(params ,"shopcode" ,""));
        ZLRpcResult rpcResult = apiShopService.getShopInfo(queryParams);
        String account = MapUtils.getString(rpcResult.getMap(), "tel");
        if (StringUtils.isEmpty(account)) {
            return "该商户没有保存手机号!!!";
        }
        Map<String, Object> data = new HashMap<String, Object>();
        if (Validator.isMobile(account)) {
            String mobileLockKey = Contants.SMS_AAS_TYPE + account + "_lock";
            String lock = RedisFactory.getDefaultClient().get(mobileLockKey);
            if (StringUtils.isNotEmpty(lock)) {
                throw new ServiceException(ServiceException.CODE_100011);
            }
            //生成验证码，如果上一次的验证码未过期，则继续使用
            String mobileKey = Contants.SMS_AAS_TYPE + account;
            String yzm = RedisFactory.getDefaultClient().get(mobileKey);
            if (StringUtils.isEmpty(yzm)) {
                //生成6位数字验证码
                yzm = CommonUtil.createRandom(true, 6);
            }

            //保存短信验证码到缓存，短信5分钟有效，300秒
            RedisFactory.getDefaultClient().set(mobileKey, yzm, 300);
            //保存短信验证锁到缓存，1分钟内不能继续发送验证码，60秒
            RedisFactory.getDefaultClient().set(mobileLockKey, yzm, 60);

            //生成6位数字验证码
            data.put("code", yzm);
            String templateCode = "SMS_116400110";
            apiSmsService.sendPlatformSms(account, templateCode, data);
            return "";
        }
        return "";
    }


    /**
     * 校验参数
     *
     * @param params
     * @return
     */
    private Map<String, Object> checkShopExist(Map<String, Object> params) {
        Map<String ,Object> queryParams = new HashMap<>();
        queryParams.put("keyword" ,MapUtils.getString(params ,"keyword" ,""));
        queryParams.put("shopcode" ,MapUtils.getString(params ,"shopcode" ,""));
        //获取关联商户数据
        ZLRpcResult rpcResult = null;
        try {
            rpcResult = apiShopService.getShopInfo(queryParams);
        } catch (Exception ex) {
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        Map<String, Object> shopInfo = rpcResult.getMap();
        if (MapUtils.isEmpty(shopInfo)) {
            throw new ServiceException("该商户不存在！");
        }

        String servercode = MapUtils.getString(shopInfo, "servercode");
        if (StringUtils.isNotEmpty(servercode)) {
            throw new ServiceException("该商户已关联！");
        }
        return shopInfo;
    }

    private Map<String, Object> formatShopInfo(Map<String, Object> shopInfo) {
        if (MapUtils.isNotEmpty(shopInfo)) {
            Map<String, Object> resultItem = new HashMap<String, Object>();
            String tel = MapUtils.getString(shopInfo, "tel");

            if (StringUtils.isNotEmpty(tel)) {
                resultItem.put("tel", tel.replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2"));
            } else {
                resultItem.put("tel", "");
            }
            resultItem.put("shopname", MapUtils.getString(shopInfo, "shopname", ""));
            resultItem.put("shopcode", MapUtils.getString(shopInfo, "shopcode", ""));
            resultItem.put("contact", MapUtils.getString(shopInfo, "contact", ""));
            resultItem.put("contactaddress", MapUtils.getString(shopInfo, "contactaddress", ""));
            resultItem.put("provinceid", MapUtils.getString(shopInfo, "provinceid", ""));
            resultItem.put("cityid", MapUtils.getString(shopInfo, "cityid", ""));
            resultItem.put("districtid", MapUtils.getString(shopInfo, "districtid", ""));
            return resultItem;
        }
        return null;
    }

}
