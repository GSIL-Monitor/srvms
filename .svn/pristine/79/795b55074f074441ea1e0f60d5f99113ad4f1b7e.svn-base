package com.wgb.controller.merchantrenewal;

import com.wgb.controller.BaseController;
import com.wgb.controller.renew.RenewController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.mbms.web.ApitMbAssistantCodeService;
import com.wgb.service.dubbo.urms.admin.ApiBranchService;
import com.wgb.service.dubbo.urms.web.ApitShopService;
import com.wgb.service.renew.RenewService;
import com.wgb.util.ArithUtil;
import com.wgb.util.Contants;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/wechattrenewal")
public class wechattrenewalController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(RenewController.class);
    @Autowired
    private ApiBranchService apiBranchService;
    @Autowired
    private RenewService service;
    @Autowired
    private ApitShopService apitShopService;
    @Autowired
    private ApitMbAssistantCodeService apitMbAssistantCodeService;

    @RequestMapping("/wehcat/wechatTable.action")
    public String showShopTable(HttpServletRequest request){
        ZLRpcResult rpcResult=new ZLRpcResult();
        Map<String, Object> params = getParams();
        rpcResult=apiBranchService.queryBranchesListForServer(params);
        if(rpcResult!=null){
            List<Map<String,Object>> shopList=rpcResult.getList();
        }
        return "merchantrenewal/wechat_renew";
    }
    @RequestMapping("/wehcat/rereact.action")
    public String rereact(HttpServletRequest request){
        ZLRpcResult rpcResult=new ZLRpcResult();
        Map<String, Object> params = getParams();
      /*  String keyword=request.getParameter("keyword");
     params.put("keyword",keyword);
        rpcResult=apiBranchService.queryBranchesListForServer(params);
*/
     /* params.put("keyword","001");*/
      rpcResult=apiBranchService.queryBranchesShopListForServer(params);

        return "merchantrenewal/branch_manage";
    }

    //微信小程序
    @RequestMapping("/wehcat/wechatplug.action")
    public String wechatplug(HttpServletRequest request){
        ZLRpcResult rpcResult=new ZLRpcResult();
        Map<String, Object> params = getParams();

        Map<String ,Object> productCode = new HashMap<>();
        productCode.put("componentcode" ,MapUtils.getString(params ,"productcode"));
        Map<String, Object> productInfo = service.queryProductInfoDetail(productCode);
        request.setAttribute("productInfo" ,productInfo);
       // String type = MapUtils.getString(params, "type");
        Map<String ,Object> queryServerDiscountParams = new HashMap<>();
        queryServerDiscountParams.put("servercode" ,MapUtils.getString(params ,"servercode"));
        Map<String, Object> serverDiscount = service.queryServerDiscount(queryServerDiscountParams);
        request.setAttribute("serverdiscount",MapUtils.getString(serverDiscount ,"appdiscountratio"));

        return "merchantrenewal/miniprogram";
    }
    @RequestMapping("payAgainMerchantStandard.action")
    public String payAgainMerchantStandard(HttpServletRequest request){
        Map<String, Object> params = getParams();
        LOGGER.info("微信小程序支付页面订单信息入参： {}" ,params);
        try {
            // 查询单据信息
            List<Map<String ,Object>> orderInfo = service.savewechatOrderInfoByBillCode(params);
            request.setAttribute("orderInfo"  ,orderInfo);
            return "renew/shop_order_pay";
        }catch (ServiceException e){
            LOGGER.error("生成微信小程序支付页面业务异常!errorMessage：" ,e );
            return "error";
        }catch (Exception ex){
            LOGGER.error("生成微信小程序支付页面失败!errorMessage：" ,ex);
            return "error";
        }
    }
    @RequestMapping("wechatplug.action")
    public String singleShop(){
      ZLRpcResult zlRpcResult=null;
      Map<String,Object> params=new HashMap<>();
        List<String> shoplist=new ArrayList<>();
        shoplist.add("125806649");
        params.put("shoplist",shoplist);
        zlRpcResult=apitShopService.queryShopListForMbms(params);
        System.out.println(zlRpcResult);
        return "singleshop/single_shop_manage";
    }

    //微信營銷插件
    @RequestMapping("/wehcat/wechatAssistant.action")
    public String wechatAssistant(HttpServletRequest request){
        ZLRpcResult rpcResult=new ZLRpcResult();
        Map<String, Object> params = getParams();
        Map<String ,Object> productCode = new HashMap<>();
        //插入商品code
        productCode.put("componentcode" ,MapUtils.getString(params ,"productcode"));
        Map<String, Object> productInfo = service.queryProductInfoDetail(productCode);
        request.setAttribute("productInfo" ,productInfo);
        String type = MapUtils.getString(params, "type");
        Map<String ,Object> queryServerDiscountParams = new HashMap<>();
        queryServerDiscountParams.put("servercode" ,MapUtils.getString(params ,"servercode"));
        Map<String, Object> serverDiscount = service.queryServerDiscount(queryServerDiscountParams);
        request.setAttribute("serverdiscount",MapUtils.getString(serverDiscount ,"appdiscountratio"));

        return "merchantrenewal/wechatAssistant";
    }
    @RequestMapping("test.action")
    public String querymbms(){
        ZLRpcResult rpcResult=new ZLRpcResult();
        Map<String,Object> map=new HashMap();
        List<String> shopcodelist=new ArrayList<>();
        shopcodelist.add("");
        map.put("shopcodelist",shopcodelist);
        rpcResult=apitMbAssistantCodeService.queryAssistantCodeForSrvms(map);
        List<Map<String,Object>> list=rpcResult.getList();

System.out.println(list);
        return "singleshop/single_shop_manage";
    }
    @RequestMapping("/wehcat/marketingAssistantadd.action")
    public String marketingAssistantadd(HttpServletRequest request){
        ZLRpcResult rpcResult=new ZLRpcResult();
        Map<String, Object> params = getParams();
        Map<String ,Object> productCode = new HashMap<>();
        productCode.put("componentcode" ,MapUtils.getString(params ,"productcode"));
        Map<String, Object> productInfo = service.queryProductInfoDetail(productCode);
        request.setAttribute("productInfo" ,productInfo);
        String type = MapUtils.getString(params, "type");
        Map<String ,Object> queryServerDiscountParams = new HashMap<>();
        queryServerDiscountParams.put("servercode" ,MapUtils.getString(params ,"servercode"));
        Map<String, Object> serverDiscount = service.queryServerDiscount(queryServerDiscountParams);
        request.setAttribute("serverdiscount",MapUtils.getString(serverDiscount ,"appdiscountratio"));

        return "merchantrenewal/marketing_Assistant_add";
    }

    @RequestMapping("/wehcat/marketingAssistant.action")
    public String marketingAssistant(HttpServletRequest request){
        ZLRpcResult rpcResult=new ZLRpcResult();
        Map<String, Object> params = getParams();
        Map<String ,Object> productCode = new HashMap<>();
        productCode.put("componentcode" ,MapUtils.getString(params ,"productcode"));
        Map<String, Object> productInfo = service.queryProductInfoDetail(productCode);
        request.setAttribute("productInfo" ,productInfo);
        String type = MapUtils.getString(params, "type");
        Map<String ,Object> queryServerDiscountParams = new HashMap<>();
        queryServerDiscountParams.put("servercode" ,MapUtils.getString(params ,"servercode"));
        Map<String, Object> serverDiscount = service.queryServerDiscount(queryServerDiscountParams);
        request.setAttribute("serverdiscount",MapUtils.getString(serverDiscount ,"appdiscountratio"));
        request.setAttribute("serverdiscount",MapUtils.getString(serverDiscount ,"appdiscountratio"));

        return "merchantrenewal/marketing_Assistant";
    }
}
