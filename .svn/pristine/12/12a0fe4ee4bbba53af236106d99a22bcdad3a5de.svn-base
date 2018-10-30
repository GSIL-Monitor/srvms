package com.wgb.controller.shop;

import com.alibaba.dubbo.config.annotation.Reference;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.service.srv.SrvRenewService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("branchRenew")
public class SrvBranchRenewController extends BaseController{

    private static final Logger LOGGER = LoggerFactory.getLogger(SrvBranchRenewController.class);

    @Autowired
    private SrvShopService srvShopService;

    @Autowired
    private SrvRenewService srvRenewService;

    /**
     * 跳转续费首页，展示店铺信息
     * @param request
     * @return
     */
    @RequestMapping("showShopTable")
    private String showShopTable(HttpServletRequest request){
          return "shop/branch_renew";
    }

    @RequestMapping("showShopTableDetail")
    private String showShopTableDetail(HttpServletRequest request){
        try {
            Map<String, Object> params = getParams();
            Page<?> pageInfo = srvShopService.queryShopAndBranchNums(params);
            request.setAttribute(Contants.PAGE_INFO, pageInfo);
          return "shop/branch_table";
        }catch (Exception e){
            LOGGER.info("SrvBranchRenewController.showShopTable 查询店铺信息失败!",e);
            return"error";
        }
    }

    /**
     *  跳转至续费页面
     * @param request
     * @return
     */
    @RequestMapping("branchRenewToView")
    public String branchRenewToView(HttpServletRequest request){
        try {
            Map<String, Object> params = getParams();
            Map<String, Object> obj = new HashMap<>();
            List<Map<String,Object>> listInfo = srvShopService.queryBranchInfoByShopCode(params);
            List<Map<String,Object>> productInfo = srvShopService.queryProductInfo(params);
            if(CollectionUtils.isNotEmpty(listInfo)){
                Map<String, Object> branchFirstInfo = listInfo.get(0);
                String shopcode = MapUtils.getString(branchFirstInfo, "shopcode");
                String shopname = MapUtils.getString(branchFirstInfo, "shopname");
                obj.put("shopcode",shopcode);
                obj.put("shopname",shopname);
            }
            if(CollectionUtils.isNotEmpty(productInfo)){
                Map<String, Object> productFirstInfo = productInfo.get(0);
                String content = MapUtils.getString(productFirstInfo, "content");
                obj.put("account",Double.parseDouble(content));
            }
            request.setAttribute("obj",obj);
            request.setAttribute("listInfo",listInfo);
            return "shop/order_add";
        }catch (Exception e){
            LOGGER.info("SrvBranchRenewController.branchRenew 跳转商户续费页面查询信息失败!");
            return"error";
        }
    }

    /**
     *  跳转至续费页面
     * @param request
     * @return
     */
    @RequestMapping("extendProbationToView")
    public String extendProbationToView(HttpServletRequest request){
        try {
            Map<String, Object> params = getParams();
            Map<String, Object> obj = new HashMap<>();
            List<Map<String,Object>> listInfo = srvShopService.queryBranchInfoByShopCode(params);
            List<Map<String,Object>> productInfo = srvShopService.queryProductInfo(params);
            if(CollectionUtils.isNotEmpty(listInfo)){
                Map<String, Object> branchFirstInfo = listInfo.get(0);
                String shopcode = MapUtils.getString(branchFirstInfo, "shopcode");
                String shopname = MapUtils.getString(branchFirstInfo, "shopname");
                obj.put("shopcode",shopcode);
                obj.put("shopname",shopname);
            }
            if(CollectionUtils.isNotEmpty(productInfo)){
                Map<String, Object> productFirstInfo = productInfo.get(0);
                String content = MapUtils.getString(productFirstInfo, "content");
                obj.put("account",Double.parseDouble(content));
            }
            obj.put("extendTime" ,7);
            request.setAttribute("obj",obj);
            request.setAttribute("listInfo",listInfo);
            return "shop/branch_extend_probation";
        }catch (Exception e){
            LOGGER.info("SrvBranchRenewController.branchRenew 跳转商户续费页面查询信息失败!");
            return"error";
        }
    }

    /**
     * 保存续费信息跳转至支付页面
     * @param request
     * @return
     */
    @RequestMapping("branchRenew")
    public String branchRenew(HttpServletRequest request){
        Map<String, Object> params = getParams();
        List<Object> renewInfo = srvRenewService.saveBranchRenew(params);

        request.setAttribute("inserOrderMain",renewInfo.get(0));
        request.setAttribute("inserOrderItem",renewInfo.get(1));
        request.setAttribute("productname",MapUtils.getString(params,"productname"));
        return "shop/selectpaytype";
    }

    /**
     * 查询续费店铺订单列表
     * @return
     */
    @RequestMapping("showOrderTable")
    public String showOrderTable(){ return "shop/renew_table";}
    /**
     * 查询续费店铺订单列表
     * @param request
     * @return
     */
    @RequestMapping("showOrderTableToView")
    public String showOrderTableToView(HttpServletRequest request){
        Map<String, Object> params = getParams();
        Page<?> pageInfo = srvRenewService.queryRenewBranchView(params);
        request.setAttribute(Contants.PAGE_INFO,pageInfo);
        return "shop/renew_table_detail";
    }

    @RequestMapping("toRenewDetail")
    public String toRenewDetail(HttpServletRequest request){
        Map<String, Object> params = getParams();
        List<Map<String, Object>> orderMainDetail = srvRenewService.queryOrderMainDetailByOrderId(params);
        List<Map<String, Object>> orderItemDetail = srvRenewService.queryOrderItemDetailByOrderId(params);
        request.setAttribute("orderMainDetail",orderMainDetail.get(0));
        request.setAttribute("orderItemDetail",orderItemDetail);
        return "shop/order_detail";
    }


    /**
     * 删除用户订单(逻辑删除)
     * @param request
     * @return
     */
    @RequestMapping("deleteOrder")
    @ResponseBody
    public String deleteOrder(HttpServletRequest request){
        Map<String, Object> params = getParams();
        String message = srvRenewService.deleteOrderByOrderId(params);
        return message;
    }

    @RequestMapping("rePayRenew")
    public String rePayRenew(HttpServletRequest request){
        Map<String, Object> params = getParams();
        Map<String, Object> result = srvRenewService.queryOrderInfoByCondition(params);
        request.setAttribute("inserOrderMain",result.get("inserOrderMain"));
        request.setAttribute("inserOrderItem",result.get("inserOrderItem"));
        request.setAttribute("productname",result.get("productname"));
        return "shop/selectpaytype";
    }


    @RequestMapping("extendProbation")
    @ResponseBody
    public String extendProbation(HttpServletRequest request){
        Map<String, Object> params = getParams();
        return srvRenewService.extendProbation(params);
    }

    @RequestMapping("checkExtendProbationCondition")
    @ResponseBody
    public String checkExtendProbationCondition(HttpServletRequest request){
        Map<String, Object> params = getParams();
        return srvRenewService.checkExtendProbationCondition(params);
    }


}
