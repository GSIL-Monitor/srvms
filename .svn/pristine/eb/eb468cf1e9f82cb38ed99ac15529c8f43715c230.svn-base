package com.wgb.controller.renew;

import com.wgb.controller.BaseController;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.mbms.web.ApitMbAssistantCodeService;
import com.wgb.service.dubbo.urms.admin.ApiBranchService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.dubbo.urms.web.ApitShopService;
import com.wgb.service.dubbo.wxms.web.ApitAppService;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-12 15:16
 **/
@Controller
@RequestMapping("renew/chooseShop")
public class ChooseShopController extends BaseController{

    @RequestMapping("singleShop.action")
    public String singleShop(){
        return "singleshop/single_shop_manage";
    }
    @RequestMapping("wechatShop.action")
    public String wechatShop(){
        return "singleshop/chooseweichatshop";
    }
    @RequestMapping("wechatAssiShop.action")
    public String wechatAssiShop(){
        return "singleshop/choosebranchforwechat";
    }

    private static final Logger LOGGER = LoggerFactory.getLogger(ChooseShopController.class);

    @Autowired
    private ApitShopService shopService;
    @Autowired
    private ApiShopService apiShopService;
    @Autowired
    private ApiBranchService  apiBranchService;
    @Autowired
    private ApitMbAssistantCodeService apitMbAssistantCodeService;
    @Autowired
    private ApitAppService apitAppService;

    /**
     * 查询续费单店
     * @param request
     * @return
     */
    @RequestMapping("findSingleShop.action")
    public String findSingleShop(HttpServletRequest request){
        Map<String, Object> params = getParams();
        ZLRpcResult rpcResult  = shopService.getShopListSoftwareForSalver(params);
        if (rpcResult.success()){
            request.setAttribute("pageInfo" ,rpcResult.getData());
        }else {
            LOGGER.error("查询续费单店调用RPC报错!" ,rpcResult.getErrorMsg());
        }
        return "singleshop/single_shop_table";
    }
    /**
     * 查询所有续费门店
     * @param request
     * @return
     */
    @RequestMapping("findallShop.action")
    public String findallShop(HttpServletRequest request){
        ZLRpcResult rpcResult1 = null;
        Map<String, Object> params = getParams();
        ZLRpcResult rpcResult  = shopService.getShopListAllForSalver(params);
        if (rpcResult.success()){
            request.setAttribute("pageInfo" ,rpcResult.getData());
        }else {
            LOGGER.error("查询续费单店调用RPC报错!" ,rpcResult.getErrorMsg());
        }
        return "singleshop/singlewechatassi";
    }

    /**
     * 查询所有续费门店
     * @param request
     * @return
     */
    @RequestMapping("findwechatallShop.action")
    public String findwechatallShop(HttpServletRequest request){
        Map<String, Object> params = getParams();
        ZLRpcResult rpcResult1 = null;
        rpcResult1  = apiShopService.queryShopcodeListForSrvms(params);
        List<Map<String,Object>> list=rpcResult1.getList();
        Map<String,Object> shopmap=new HashMap();
        List<String> shoplist=new ArrayList<>();

        for(Map<String,Object> map:list){
            String shopcode=MapUtils.getString(map,"shopcode");
            shoplist.add(shopcode);
        }
        shopmap.put("shopcodelist",shoplist);
        shopmap.put("page" ,MapUtils.getIntValue(params ,"page"));
        shopmap.put("pageSize" ,MapUtils.getIntValue(params ,"pageSize"));
        ZLRpcResult rpcResult  = apitAppService.queryShopAppInfos(shopmap);
        if (rpcResult.success()){
            request.setAttribute("pageInfo" ,rpcResult.getData());
        }else {
            LOGGER.error("查询续费单店调用RPC报错!" ,rpcResult.getErrorMsg());
        }
        return "singleshop/singlewechat";
    }

    @RequestMapping("findMultipleShop.action")
    @ResponseBody
    public List<Map<String ,Object>> findMultipleShop(HttpServletRequest request){
        List<Map<String ,Object>> multipleShops = new ArrayList<>();
        Map<String, Object> params = getParams();
        ZLRpcResult rpcResult = null;
        ZLRpcResult rpcResultforass = null;
        String type = MapUtils.getString(params, "type");
        if ("renew".equalsIgnoreCase(type)){
            rpcResult  = shopService.getShopListForSalver(params);  //续费连锁
            if (rpcResult.success()){
                return (List<Map<String ,Object>>)rpcResult.getData();
            }else {
                LOGGER.error("查询续费连锁调用RPC报错!" ,rpcResult.getErrorMsg());
            }
        }
        if ("4".equalsIgnoreCase(type)){
            {
                rpcResult  = apiShopService.queryShopcodeListForSrvms(params);
                List<Map<String,Object>> list=rpcResult.getList();
                Map<String,Object> shopmap=new HashMap();
                List<String> shoplist=new ArrayList<>();

                for(Map<String,Object> map:list){
                    String shopcode=MapUtils.getString(map,"shopcode");
                    shoplist.add(shopcode);
                }
                if(shoplist.size()==0){
                    shoplist.add("12345") ;
                }
                shopmap.put("shopcodelist",shoplist);
                rpcResult  = apitAppService.queryMiniAppInfos(shopmap);
                if (rpcResult.success()){
                    return (List<Map<String ,Object>>)rpcResult.getData();
                }else {
                    LOGGER.error("查询门店调用RPC报错!" ,rpcResult.getErrorMsg());
                }
            }
        }
        if ("5".equalsIgnoreCase(type)){
            rpcResult  = apiShopService.queryShopcodeListForSrvms(params);
            List<Map<String,Object>> list=rpcResult.getList();
            Map<String,Object> shopmap=new HashMap();
            List<String> shoplist=new ArrayList<>();

            for(Map<String,Object> map:list){
                String shopcode=MapUtils.getString(map,"shopcode");
                shoplist.add(shopcode);
            }
            if(shoplist.size()==0){
                shoplist.add("12345") ;
            }
            shopmap.put("shopcodelist",shoplist);

            rpcResultforass=apitMbAssistantCodeService.queryAssistantCodeForSrvms(shopmap);
            if (rpcResult.success()){
                return rpcResultforass.getList();
            }else {
                LOGGER.error("查询门店调用RPC报错!" ,rpcResult.getErrorMsg());
            }
        }
        String single = MapUtils.getString(params, "single");
        String multiple = MapUtils.getString(params, "multiple");
        if ("extend".equalsIgnoreCase(type)){
            if ("single".equalsIgnoreCase(single)){
                rpcResult  = shopService.getShopListRechargeSoftwareForSalver(params);
                if (rpcResult.success()){
                    return (List<Map<String ,Object>>)rpcResult.getData();
                }else {
                    LOGGER.error("查询延期单店调用RPC报错!" ,rpcResult.getErrorMsg());
                }
            }
            if ("multiple".equalsIgnoreCase(multiple)){
                rpcResult  = shopService.getShopListRechargeForSalver(params);
                if (rpcResult.success()){
                    return (List<Map<String ,Object>>)rpcResult.getData();
                }else {
                    LOGGER.error("查询门店调用RPC报错!" ,rpcResult.getErrorMsg());
                }
            }

        }
        return multipleShops;
    }

}
