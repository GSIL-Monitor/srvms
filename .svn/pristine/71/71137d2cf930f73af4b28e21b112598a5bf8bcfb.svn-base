package com.wgb.controller.association;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.srv.SrvAssociationShopService;
import com.wgb.service.srv.SrvService;
import com.wgb.service.srv.SrvShopService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yjw on 2017/11/8
 */
@Controller
@RequestMapping("/srv/association")
public class AssociationShopController extends BaseController {

    @Autowired
    private SrvAssociationShopService associationShopService;

    @Autowired
    private ApiShopService apiShopService;

    @Autowired
    private SrvShopService srvShopService;

    @RequestMapping("toAssociationView")
    public String toAssociationView(HttpServletRequest request){
        Map<String, Object> params = getParams();
        String servercode = MapUtils.getString(params, "servercode");
        if (StringUtils.isBlank(servercode)){
            return "error";
        }
        request.setAttribute("servercode" ,servercode);
        return "association/association_shop";
    }

    /*
     *获取关联商户数据
     */
    @RequestMapping("/getShopInfo")
    @ResponseBody
    public ZLResult getShopInfo(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        String shopcode = MapUtils.getString(params, "shopcode", "");
        String dutypersonnum = MapUtils.getString(params, "dutypersonnum", "");
        if (StringUtils.isEmpty(shopcode) && StringUtils.isEmpty(dutypersonnum)) {
            return ZLResult.Error("请输入正确的商户ID或商户联系人手机号！");
        }
        Map<String, Object> shopInfo = getShopInfo(params);
        Map<String, Object> data = formatShopInfo(shopInfo);
        result.setData(data);
        return result;
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

    /**
     * 校验参数
     *
     * @param params
     * @return
     */
    private Map<String, Object> getShopInfo(Map<String, Object> params) {
        Map<String ,Object> queryParams = new HashMap<>();
        queryParams.put("shopcode" ,MapUtils.getString(params ,"shopcode" ,""));
        queryParams.put("dutypersonnum" ,MapUtils.getString(params ,"dutypersonnum" ,""));
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


    /*
     *关联商户
     */
    @RequestMapping("/addAssociationInfo")
    @ResponseBody
    public String addAssociationInfo(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        //校验商户是否存在
        Map<String, Object> shopInfo = getShopInfo(params);
        // 设置省市区
        String area = getShopArea(params);
        params.put("shoparea" ,area);
        // 获取服务商信息信息
        Map<String, Object> srvShopInfo = srvShopService.getSrvShopInfo(params);
        // 设置保存信息
        Map<String, Object> associationInfo = new HashMap<String, Object>();
        formatAssociationInfo(associationInfo ,shopInfo ,srvShopInfo ,params);
        // 保存服务商商户关联信息
        associationShopService.updateAssociation(associationInfo);
        return "";
    }

    private String getShopArea(Map<String, Object> params) {
        //现在商户区域没有必输
        String provincename = MapUtils.getString(params, "provincename");
        String cityname = MapUtils.getString(params, "cityname");
        String districtname = MapUtils.getString(params, "districtname");
        String shoparea = "";
        if (!"请选择".equals(cityname)) {
            shoparea = provincename + "-" + cityname + "-" + districtname;
        }
        return shoparea;
    }


    private void formatAssociationInfo( Map<String, Object> associationInfo ,Map<String, Object> shopInfo ,Map<String, Object> srvShopInfo ,Map<String, Object> params){
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
        associationInfo.put("shoparea", MapUtils.getString(params, "shoparea" ,""));
    }
}
