package com.wgb.controller.renew;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.renew.RenewService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-11 10:59
 *  商户续费
 **/
@Controller
@RequestMapping("/renew/order")
public class RenewController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(RenewController.class);
    @Autowired
    private RenewService service;

    /**
     * 续费列表跳转页面
     * @param request
     * @return
     */
    @RequestMapping("orderManage.action")
    public String orderManage(HttpServletRequest request){
        // 查询商品列表 -- 条件使用
        List<Map<String, Object>> productList = service.queryProductInfoByCondition(new HashMap<String, Object>());
        request.setAttribute("productList" ,productList);
        return "renew/order_manage";
    }
    /**
     * 查询列表
     * @param request
     * @return
     */
    @RequestMapping("queryOrderInfoList.action")
    public String queryOrderInfoList(HttpServletRequest request){
        Map<String, Object> params = getParams();
        LOGGER.info("查询订单信息列表入参： {}" ,params);
        try {
            // 查询订单信息
            Page pageInfo = service.queryOrderInfoByCondition(params);
            request.setAttribute("pageInfo" ,pageInfo);
            return "renew/order_manage_table";
        }catch (ServiceException e){
            LOGGER.error("查询订单信息列表业务异常!errorMessage：" ,e );
            return "error";
        }catch (Exception ex){
            LOGGER.error("查询订单信息列表失败!errorMessage：" ,ex);
            return "error";
        }
    }

    /**
     * 查询单店续费详情
     * @param request
     * @return
     */
    @RequestMapping("merchantStandardDetail.action")
    public String merchantStandardDetail(HttpServletRequest request){
        Map<String, Object> params = getParams();
        LOGGER.info("查询店铺订单详情信息入参： {}" ,params);
        try {
            List<Map<String, Object>> merchantDetail = service.queryMerchantDetail(params);
            request.setAttribute("merchantDetail" ,merchantDetail);
            return "renew/shop_order_detail";
        }catch (ServiceException e){
            LOGGER.error("查询店铺订单详情业务异常!errorMessage：" ,e );
            return "error";
        }catch (Exception ex){
            LOGGER.error("查询店铺订单详情失败!errorMessage：" ,ex);
            return "error";
        }
    }

    /**
     * 删除连锁版
     * @param request
     * @return
     */
    @RequestMapping("deleteOrderInfo.action")
    @ResponseBody
    public ZLResult deleteOrderInfo(HttpServletRequest request){
        Map<String, Object> params = getParams();
        LOGGER.info("删除连锁店订单信息入参： {}" ,params);
        ZLResult result = ZLResult.Success();
        try {
            String message = service.deleteOrderInfo(params);
            result.setData(message);
        }catch (ServiceException e){
            LOGGER.error("删除单店订单业务异常!errorMessage：" ,e );
            result  = ZLResult.Error("删除订单异常!请联系管理员!");
        }catch (Exception ex){
            LOGGER.error("删除单店订单信息失败!errorMessage：" ,ex);
            result  = ZLResult.Error("删除订单异常!请联系管理员!");
        }
        return result;
    }

    /**
     * 单店支付页面
     * @param request
     * @return
     */
    @RequestMapping("payAgainMerchantStandard.action")
    @ResponseBody
    public ZLResult payAgainMerchantStandard(HttpServletRequest request){
        Map<String, Object> params = getParams();
        ZLResult result = ZLResult.Success();
        LOGGER.info("单店支付页面订单信息入参： {}" ,params);
        LOGGER.info("到期时间:{}" ,"11111111111111111111111");
        try {
            String billcode = service.saveOrderInfoByBillCode(params);
            result.setData(billcode);
        }catch (ServiceException e){
            LOGGER.error("生成单店支付页面业务异常!errorMessage：" ,e );
            result = ZLResult.Error("生成单店支付页面业务异常!请联系管理员!");

        }catch (Exception ex){
            result = ZLResult.Error("生成单店支付页面失败!请联系管理员!");
            LOGGER.error("生成单店支付页面失败!errorMessage：" ,ex);
        }
        return result;
    }

    /**
     * 跳转支付页面
     * @param request
     * @return
     */
    @RequestMapping("toPayView.action")
    public String toPayView(HttpServletRequest request){
        Map<String, Object> params = getParams();
        if (StringUtils.isBlank(MapUtils.getString(params, "billcode"))){
            request.setAttribute("error" ,"请勿非法操作!");
            return "error";
        }
        List<Map<String ,Object>> orderInfo = service.queryPayOrderInfoByBillCode(params);
        request.setAttribute("orderInfo"  ,orderInfo);
        request.setAttribute("servercode"  ,MapUtils.getString(params ,"servercode"));

        return "/renew/shop_order_pay";
    }
    @RequestMapping("wechattoPayView.action")
    public String wechattoPayView(HttpServletRequest request){
        Map<String, Object> params = getParams();
        if (StringUtils.isBlank(MapUtils.getString(params, "billcode"))){
            request.setAttribute("error" ,"请勿非法操作!");
            return "error";
        }
        List<Map<String ,Object>> orderInfo = service.queryPayOrderInfoByBillCode(params);
        request.setAttribute("orderInfo"  ,orderInfo);
        request.setAttribute("servercode"  ,MapUtils.getString(params ,"servercode"));

        return "/merchantrenewal/payassistant";
    }

    //跳转页面用
    @RequestMapping("productManage.action")
    public String productManage(HttpServletRequest request){
        return "/renew/product_manage";
    }

    // 跳转应用商品页面
    @RequestMapping("queryProductList.action")
    public String queryProductList(HttpServletRequest request){
        Map<String, Object> params = getParams();
        LOGGER.info("查询应用软件信息： {}" ,params);
        try {
            // 查询单据信息
            Page pageInfo = service.queryProductInfo(params);
            request.setAttribute("pageInfo" ,pageInfo);
            return "/renew/product_table";
        }catch (ServiceException e){
            LOGGER.error("查询应用软件信息业务异常!errorMessage：" ,e );
            return "error";
        }catch (Exception ex){
            LOGGER.error("查询应用软件信息失败!errorMessage：" ,ex);
            return "error";
        }
    }

    // 跳转订单填写页面

    @RequestMapping("writeRenew.action")
    public String writeRenew(HttpServletRequest request){
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

        String view = null;
        switch (type){
            case "0" : view = "/renew/single_shop_renew";   // 单店续费页面
            break;
            case "1" : view = "/renew/multiple_shop_renew";  // 连锁门店续费页面
            break;
            default:view = "error";
        }
        return view;
    }

}
