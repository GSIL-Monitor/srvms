package com.wgb.controller.income;

import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.dubbo.pays.admin.ApiPayIncomeService;
import com.wgb.service.dubbo.pays.admin.ApiShopConfigService;
import com.wgb.service.dubbo.urms.admin.ApiShopService;
import com.wgb.service.srv.SrvService;
import com.wgb.util.ArithUtil;
import com.wgb.util.Contants;
import com.wgb.util.ExcelUtil;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/service")
public class ServiceIncomeController  extends BaseController {
    protected final Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private ApiShopConfigService apiShopConfigService;
    @Autowired
    private ApiPayIncomeService apiPayIncomeService;
    @Autowired
    private SrvService srvService;

    @RequestMapping("/serviceincome/manage")
    public String manage(HttpServletRequest request) {
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        Map<String, Object> params = getParams();
        try {
            //系统调用
            zlRpcResult = apiPayIncomeService.getServiceIncomeList(params);
        } catch (Exception ex) {
            logger.error("api收单收益异常,输入参数 =" + params, ex);
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        if (!zlRpcResult.success()) {
            throw new ServiceException(zlRpcResult.getErrorMsg());
        }
        Page pageInfo = (Page) zlRpcResult.getData();


        List<Map<String, Object>> paylist = pageInfo.getList();
        if (paylist != null){
            for (Map<String, Object> payMap : paylist) {
                Map<String, Object> map = srvService.queryService(payMap);
                String alirevenuescale = MapUtils.getString(map, "alirevenuescale");
                String weixirevenuescale = MapUtils.getString(map, "weixirevenuescale");

                String paymethod = MapUtils.getString(payMap, "paymethod");
                String sshouldpayamount = MapUtils.getString(payMap, "sshouldpayamount");
                Double payamount=0.0;
                if(!StringUtils.isEmpty(sshouldpayamount)){
                    payamount= Double.parseDouble(sshouldpayamount);
                }

                if ("0".equals(paymethod)) {
                    if(!StringUtils.isEmpty(weixirevenuescale)){
                        payMap.put("settlerate", weixirevenuescale);
                        Double weixirevenuescal = Double.parseDouble(weixirevenuescale);
                        Double b = ArithUtil.mul(payamount, weixirevenuescal);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("shouldpayamount", relmoney);
                    }
                    else{
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("shouldpayamount", relmoney);

                    }
                }
                else if ("1".equals(paymethod)) {
                    if(!StringUtils.isEmpty(alirevenuescale)){
                        payMap.put("settlerate", alirevenuescale);
                        Double alibill = Double.parseDouble(alirevenuescale);
                        Double b = ArithUtil.mul(payamount, alibill);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("shouldpayamount", relmoney);
                    }
                    else{
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("shouldpayamount", relmoney);
                    }


                }
            }
        }
        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "income/shop_manage_detail";
    }
    @RequestMapping("/serviceincome/payBillDetail")
    public String payBillDetail(HttpServletRequest request) {
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        Map<String, Object> params = getParams();
        try {
            //系统调用
            zlRpcResult = apiPayIncomeService.getServiceIncomeDetail(params);
        } catch (Exception ex) {
            logger.error("api收单收益详情异常,输入参数 =" + params, ex);
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        if (!zlRpcResult.success()) {
            throw new ServiceException(zlRpcResult.getErrorMsg());
        }
        Page pageInfo = (Page) zlRpcResult.getData();
        List<Map<String, Object>> paylist = pageInfo.getList();
        if (paylist != null){
            for (Map<String, Object> payMap : paylist) {
                Map<String, Object> map = srvService.queryService(payMap);
                String alirevenuescale = MapUtils.getString(map, "alirevenuescale");
                String weixirevenuescale = MapUtils.getString(map, "weixirevenuescale");

                String paymethod = MapUtils.getString(payMap, "paymethod");
                String sshouldpayamount = MapUtils.getString(payMap, "shouldpayamount");
                Double payamount=0.0;
                if(!StringUtils.isEmpty(sshouldpayamount)){
                    payamount= Double.parseDouble(sshouldpayamount);
                }
                if ("0".equals(paymethod)) {
                    if(!StringUtils.isEmpty(weixirevenuescale)){
                        payMap.put("settlerate", weixirevenuescale);
                        Double weixirevenuescal = Double.parseDouble(weixirevenuescale);
                        Double b = ArithUtil.mul(payamount, weixirevenuescal);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", relmoney);
                    }
                    else {
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", relmoney);

                    }

                } else if ("1".equals(paymethod)) {
                    if(!StringUtils.isEmpty(alirevenuescale)){
                        payMap.put("settlerate", alirevenuescale);
                        Double alibill = Double.parseDouble(alirevenuescale);
                        Double b = ArithUtil.mul(payamount, alibill);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", relmoney);
                    }
                    else {
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", relmoney);

                    }
                }
            }
    }
        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        request.setAttribute("paymethod", params.get("paymethod"));
        request.setAttribute("month", params.get("month"));
        request.setAttribute("servercode", params.get("servercode"));
        return "income/income_paydetail";
    }
    @RequestMapping("/serviceincome/payBillDetailforcheck")
    public String payBillDetailforcheck(HttpServletRequest request) {
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        Map<String, Object> params = getParams();
        try {
            //系统调用
            zlRpcResult = apiPayIncomeService.getServiceDetail(params);
        } catch (Exception ex) {
            logger.error("api收单收益异常,输入参数 =" + params, ex);
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        if (!zlRpcResult.success()) {
            throw new ServiceException(zlRpcResult.getErrorMsg());
        }
        Page pageInfo = (Page) zlRpcResult.getData();
        List<Map<String, Object>> paylist = pageInfo.getList();
        if (paylist != null){
            for (Map<String, Object> payMap : paylist) {
                Map<String, Object> map = srvService.queryService(payMap);
                String alirevenuescale = MapUtils.getString(map, "alirevenuescale");
                String weixirevenuescale = MapUtils.getString(map, "weixirevenuescale");

                String paymethod = MapUtils.getString(payMap, "paymethod");
                String sshouldpayamount = MapUtils.getString(payMap, "shouldpayamount");
                Double payamount=0.0;
                if(!StringUtils.isEmpty(sshouldpayamount)){
                    payamount= Double.parseDouble(sshouldpayamount);
                }
                if ("0".equals(paymethod)) {
                    if(!StringUtils.isEmpty(weixirevenuescale)){
                        payMap.put("settlerate", weixirevenuescale);
                        Double weixirevenuescal = Double.parseDouble(weixirevenuescale);
                        Double b = ArithUtil.mul(payamount, weixirevenuescal);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", relmoney);
                    }
                    else {
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", relmoney);

                    }

                } else if ("1".equals(paymethod)) {
                    if(!StringUtils.isEmpty(alirevenuescale)){
                        payMap.put("settlerate", alirevenuescale);
                        Double alibill = Double.parseDouble(alirevenuescale);
                        Double b = ArithUtil.mul(payamount, alibill);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", relmoney);
                    }
                    else {
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", relmoney);

                    }
                }
            }
        }
        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        request.setAttribute("paymethod", params.get("paymethod"));
        request.setAttribute("month", params.get("month"));
        request.setAttribute("servercode", params.get("servercode"));
        return "income/income_paydetailforcheck";
    }
    @RequestMapping("/serviceincome/payBillDetailExport")
    public void payBillDetailExport(HttpServletRequest request, HttpServletResponse response) {
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        Map<String, Object> params = getParams();
        Page pageInfo=null;

        try {
            //系统调用
            zlRpcResult = apiPayIncomeService.getServiceDetail(params);
        } catch (Exception ex) {
            logger.error("收单收益详情导出异常,输入参数 =" + params, ex);
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        if (!zlRpcResult.success()) {
            throw new ServiceException(zlRpcResult.getErrorMsg());
        }
        Page page=(Page)zlRpcResult.getData();
        List<Map<String, Object>> paylist =page.getList();
        if (paylist != null){
            if (paylist.size() == 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("branchname", "暂无数据");
                paylist.add(map);
                String[] members = {"branchname", "shopname", "servername", "relpayamount",
                        "returnmoney", "settlerate", "sshouldpayamount", "shouldpayamount"};
                String[] memberNames = {"门店名称", "所属商户", "所属服务商", "有效收单金额（元）",
                        "有效退款金额（元）", "服务商收益比例", "服务收益总额（元)", "平台总收益（元)"};

                String menberName = "收单收益表";

                ExcelUtil.exportExcel(paylist, members, memberNames, menberName, request, response);

            }
            else{
            for (Map<String, Object> payMap : paylist) {
                Map<String, Object> map = srvService.queryService(payMap);
                String alirevenuescale = MapUtils.getString(map, "alirevenuescale");
                String weixirevenuescale = MapUtils.getString(map, "weixirevenuescale");

                String paymethod = MapUtils.getString(payMap, "paymethod");
                String sshouldpayamount = MapUtils.getString(payMap, "shouldpayamount");
                Double payamount=0.0;
                if(!StringUtils.isEmpty(sshouldpayamount)){
                    payamount= Double.parseDouble(sshouldpayamount);
                }
                if ("0".equals(paymethod)) {
                    if(!StringUtils.isEmpty(weixirevenuescale)){
                        payMap.put("settlerate", weixirevenuescale);
                        Double weixirevenuescal = Double.parseDouble(weixirevenuescale);
                        Double b = ArithUtil.mul(payamount, weixirevenuescal);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", myRound(relmoney,2));
                    }
                    else {
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", myRound(relmoney,2));

                    }
                } else if ("1".equals(paymethod)) {
                    if(!StringUtils.isEmpty(alirevenuescale)){
                        payMap.put("settlerate", alirevenuescale);
                        Double alibill = Double.parseDouble(alirevenuescale);
                        Double b = ArithUtil.mul(payamount, alibill);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", myRound(relmoney,2));
                    }
                    else {
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("relmoney", myRound(relmoney,2));
                    }
                }
            }
        }
        if(paylist!=null){
            for (Map<String, Object> payMap : paylist){
                String paymethod = MapUtils.getString(payMap, "paymethod");
                if("0".equals(paymethod)){
                    payMap.put("paymethod","微信");
                }
                else if ("1".equals(paymethod))
                {
                    payMap.put("paymethod","支付宝");
                }
            }
        String[] members = {"shopname", "branchname", "relpayamount", "Transactionno",
                "returnmoney", "returnpercent", "shouldpayamount","settlerate","relmoney"};
        String[] memberNames = {"收单商户", "收单门店", "有效收单金额（元）", "有效收单笔数（笔）",
                "有效退款金额（元）", "有效退款笔数（笔）", "有效收益基数（元）","收益比例","收益金额"};

        String menberName = "收单收益详情表";

        ExcelUtil.exportExcel(paylist, members, memberNames, menberName, request, response);
    }
        }
    }
    private static double myRound(double number,int index){
        double result = 0;
        double temp = Math.pow(10, index);
        result = Math.round(number*temp)/temp;
        return result;
    }
}
