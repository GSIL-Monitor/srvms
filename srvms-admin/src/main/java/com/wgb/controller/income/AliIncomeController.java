package com.wgb.controller.income;

import com.wgb.bean.ZLResult;
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
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/lucre")
public class AliIncomeController  extends BaseController {
    protected final Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private ApiShopConfigService apiShopConfigService;
    @Autowired
    private ApiPayIncomeService apiPayIncomeService;
    @Autowired
    private ApiShopService apiShopService;
    @Autowired
    private SrvService srvService;

    /**
     * 收益结算
     * @param request
     * @return
     */
    @RequestMapping("/manage")
    public String manage(HttpServletRequest request) {
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        ZLRpcResult zlRpcResultForConfig = new ZLRpcResult();
        ZLRpcResult zlRpcResultForShop = new ZLRpcResult();
        ZLRpcResult zlRpcResultForIncome = new ZLRpcResult();
        ZLRpcResult zlRpcResultForupdate = new ZLRpcResult();
        ZLRpcResult   zl= new ZLRpcResult();

        Map<String, Object> params = getParams();
        String mchid=null;

        try {
            //系统调用
            zlRpcResult = apiPayIncomeService.getPayIncomeList(params);
        } catch (Exception ex) {
            logger.error("API获取收益结算,输入参数 =" + params, ex);
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        //判断返回结果
        if (!zlRpcResult.success()) {
            throw new ServiceException(zlRpcResult.getErrorMsg());
        }
        Page page =(Page)zlRpcResult.getData();
        List<Map<String,Object>>   incomList=page.getList();

        if(null!=incomList) {
            for (Map<String, Object> income : incomList) {
                try {
                    //系统调用
                    Map<String, Object> payMethodMap = new HashMap<>();
                    String payMethod = MapUtils.getString(income, "payMethod");
                    mchid = MapUtils.getString(income, "mchid");
                    if ("0".equals(payMethod)) {
                        payMethodMap.put("wxshopid", mchid);
                    } else if ("1".equals(payMethod)) {
                        payMethodMap.put("alishoppid", mchid);
                    }


                    zlRpcResultForConfig = apiShopConfigService.getIncomeConfig(payMethodMap);
                } catch (Exception ex) {
                    logger.error("API获取收益配置异常,输入参数 =" + params, ex);
                    //系统级别异常
                    throw new ServiceException(ServiceException.SYS_ERROR);
                }
                Map<String, Object> config = (Map) zlRpcResultForConfig.getData();
                String shopcode = MapUtils.getString(config, "shopcode");
                String brancode = MapUtils.getString(config, "brancode");
                String branchname = MapUtils.getString(config, "branchname");
                Map<String,Object>  m=new HashMap();
                m.put("shopcode",shopcode);
                zl=apiShopService.queryBranchnameByShopcode(m);
                Map<String,Object> shopMap=zl.getMap();
                String shopname = MapUtils.getString(shopMap, "shopname");
                try {
                    //系统调用
                    Map<String, Object> shop = new HashMap<>();
                    shop.put("shopcode", shopcode);
                    zlRpcResultForShop = apiShopService.queryServerByShopcode(shop);
                } catch (Exception ex) {
                    logger.error("API获取服务商异常,输入参数 =" + params, ex);
                    throw new ServiceException(ServiceException.SYS_ERROR);
                }
                Map<String, Object> serviceMap=new HashMap<>();
                if(zlRpcResultForShop!=null){
                    serviceMap= (Map) zlRpcResultForShop.getData();
                }
                String servercode = MapUtils.getString(serviceMap, "servercode");
                String servername = MapUtils.getString(serviceMap, "servername");
                try {
                    //系统调用
                    Map<String, Object> incomeService = new HashMap<>();
                    incomeService.put("mchid", mchid);
                    incomeService.put("servercode", servercode);
                    incomeService.put("servername", servername);
                    incomeService.put("brancode", brancode);
                    incomeService.put("branchname", branchname);
                    incomeService.put("shopname", shopname);
                    incomeService.put("shopcode", shopcode);
                    zlRpcResultForIncome = apiPayIncomeService.updateService(incomeService);
                } catch (Exception ex) {
                    logger.error("API更新服务商异常,输入参数 =" + params, ex);
                    throw new ServiceException(ServiceException.SYS_ERROR);
                }
            }
        }
        try {
            //系统调用
            zlRpcResultForupdate = apiPayIncomeService.getPayIncomeList(params);
        } catch (Exception ex) {
            logger.error("API获取支付详细,输入参数 =" + params, ex);
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        //判断返回结果
        if (!zlRpcResultForupdate.success()) {
            throw new ServiceException(zlRpcResult.getErrorMsg());
        }
        Page pageInfo =(Page)zlRpcResult.getData();
        List<Map<String, Object>> paylist = pageInfo.getList();
        if (paylist != null){
            for (Map<String, Object> payMap : paylist) {
                Map<String, Object> map = srvService.queryService(payMap);
              String   tel=MapUtils.getString(map, "tel");
              String servercode=MapUtils.getString(payMap, "servercode");
              Map<String,Object> serviceCodeMap=new HashMap<>();
                serviceCodeMap.put("tel",tel);
                serviceCodeMap.put("servercode",servercode);
                if(servercode!=null){
                    zlRpcResultForIncome = apiPayIncomeService.updateServiceTel(serviceCodeMap);
                }
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
                        payMap.put("sshouldpayamount", relmoney);
                    }
                    else{
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("sshouldpayamount", relmoney);

                    }
                }
                else if ("1".equals(paymethod)) {
                    if(!StringUtils.isEmpty(alirevenuescale)){
                        payMap.put("settlerate", alirevenuescale);
                        Double alibill = Double.parseDouble(alirevenuescale);
                        Double b = ArithUtil.mul(payamount, alibill);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("sshouldpayamount", relmoney);
                    }
                    else{
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("sshouldpayamount", relmoney);
                    }
                }
            }
        }
        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "income/member_manage";
    }
    /**
     * 收益结算导出
     * @param request
     * @return
     */
    @RequestMapping("/getPayIncomeListExport")
    public Map  getPayIncomeListExport( HttpServletRequest request, HttpServletResponse response)  {
        Map<String, Object> params = getParams();
        ZLRpcResult zlRpcResultForupdate = new ZLRpcResult();
        try {
            //系统调用
            zlRpcResultForupdate = apiPayIncomeService.getPayIncomeListExp(params);
        } catch (Exception ex) {
            logger.error("收益结算导出异常,输入参数 =" + params, ex);
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        //判断返回结果
        if (!zlRpcResultForupdate.success()) {
            throw new ServiceException(zlRpcResultForupdate.getErrorMsg());
        }

        List<Map<String, Object>> paylist=(List<Map<String, Object>>)zlRpcResultForupdate.getData();

        if (paylist != null){
            if(paylist.size()==0){
               Map<String,Object> map=new HashMap<>();
               map.put("month","暂无数据");
                paylist.add(map);
                String[] members = {"month", "servername", "paymethod", "relpayamount",
                        "Transactionno", "returnmoney", "returnpercent", "shouldpayamount", "Transactionno", "settlerate", "sshouldpayamount"
                        , "settlestate"};
                String[] memberNames = {"结算月份", "服务商名称", "收单方式", "有效收单金额",
                        "有效笔数（笔）", "有效退款金额", "有效退款笔数", "有效收益基数", "有效交易净笔数", "收益比例", "收益金额", "结算状态"};

                String menberName = "收单收益结算表";

                ExcelUtil.exportExcel(paylist, members, memberNames, menberName, request, response);

            }
    else {
                for (Map<String, Object> payMap : paylist) {
                    Map<String, Object> map = srvService.queryService(payMap);
                    String settlestate = MapUtils.getString(payMap, "settlestate");
                    String alirevenuescale = MapUtils.getString(map, "alirevenuescale");
                    String weixirevenuescale = MapUtils.getString(map, "weixirevenuescale");

                    String paymethod = MapUtils.getString(payMap, "paymethod");
                    String sshouldpayamount = MapUtils.getString(payMap, "shouldpayamount");
                    Double payamount = 0.0;
                    if (!StringUtils.isEmpty(sshouldpayamount)) {
                        payamount = Double.parseDouble(sshouldpayamount);
                    }

                    if ("0".equals(paymethod)) {
                        if (!StringUtils.isEmpty(weixirevenuescale)) {
                            payMap.put("settlerate", weixirevenuescale);
                            Double weixirevenuescal = Double.parseDouble(weixirevenuescale);
                            Double b = ArithUtil.mul(payamount, weixirevenuescal);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("sshouldpayamount", myRound(relmoney, 2));
                        } else {
                            payMap.put("settlerate", "0");
                            Double b = ArithUtil.mul(payamount, 0);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("sshouldpayamount", myRound(relmoney, 2));

                        }
                    } else if ("1".equals(paymethod)) {
                        if (!StringUtils.isEmpty(alirevenuescale)) {
                            payMap.put("settlerate", alirevenuescale);
                            Double alibill = Double.parseDouble(alirevenuescale);
                            Double b = ArithUtil.mul(payamount, alibill);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("sshouldpayamount", myRound(relmoney, 2));
                        } else {
                            payMap.put("settlerate", "0");
                            Double b = ArithUtil.mul(payamount, 0);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("sshouldpayamount", myRound(relmoney, 2));
                        }
                    }
                    if ("0".equals(settlestate)) {
                        payMap.put("settlestate", "未结算");
                    } else if ("1".equals(settlestate)) {
                        payMap.put("settlestate", "已结算");
                    }
                    if ("0".equals(paymethod)) {
                        payMap.put("paymethod", "微信");
                    } else if ("1".equals(paymethod)) {
                        payMap.put("paymethod", "支付宝");
                    }
                    if ("0".equals(paymethod)) {
                        payMap.put("paymethod", "微信");
                    } else if ("1".equals(paymethod)) {
                        payMap.put("paymethod", "支付宝");
                    }
                }
                String[] members = {"month", "servername", "paymethod", "relpayamount",
                        "Transactionno", "returnmoney", "returnpercent", "shouldpayamount", "Transactionno", "settlerate", "sshouldpayamount"
                        , "settlestate"};
                String[] memberNames = {"结算月份", "服务商名称", "收单方式", "有效收单金额",
                        "有效笔数（笔）", "有效退款金额", "有效退款笔数", "有效收益基数", "有效交易净笔数", "收益比例", "收益金额", "结算状态"};

                String menberName = "收单收益结算表";

                ExcelUtil.exportExcel(paylist, members, memberNames, menberName, request, response);
            }
        }

        return null;
    }
    /**
     * 收单收益
     * @param request
     * @return
     */
    @RequestMapping("/income/incomebymonth")
    public String showShopTable(HttpServletRequest request){
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        Map<String, Object> params = getParams();
        try {
            //系统调用
            zlRpcResult = apiPayIncomeService.getPayIncomeByMonth(params);
        } catch (Exception ex) {
            logger.error("获取收单收益异常,输入参数 =" + params, ex);
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
                        Double servicerelmoney=myRound(relmoney,2);
                        Double servicerelmoney1=payamount-servicerelmoney;
                        payMap.put("ssshouldpayamount",myRound(servicerelmoney1,2));
                        payMap.put("shouldpayamount", myRound(relmoney,2));
                    }
                    else {
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        Double servicerelmoney=myRound(relmoney,2);
                        Double servicerelmoney1=payamount-servicerelmoney;
                        payMap.put("ssshouldpayamount",myRound(servicerelmoney1,2));
                        payMap.put("shouldpayamount", myRound(relmoney,2));
                    }

                } else if ("1".equals(paymethod)) {
                    if(!StringUtils.isEmpty(alirevenuescale)){
                        payMap.put("settlerate", alirevenuescale);
                        Double alibill = Double.parseDouble(alirevenuescale);
                        Double b = ArithUtil.mul(payamount, alibill);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        Double servicerelmoney=myRound(relmoney,2);
                        Double servicerelmoney1=payamount-servicerelmoney;
                        payMap.put("ssshouldpayamount",myRound(servicerelmoney1,2));
                        payMap.put("shouldpayamount", myRound(relmoney,2));
                    }
                    else{
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        Double servicerelmoney=myRound(relmoney,2);
                        Double servicerelmoney1=payamount-servicerelmoney;
                        payMap.put("ssshouldpayamount",myRound(servicerelmoney1,2));
                        payMap.put("shouldpayamount", myRound(relmoney,2));
                    }

                }
            }
        }   request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "income/file_manage";
    }
    /**
     * 收单收益导出
     * @param request
     * @return
     */
    @RequestMapping("/income/incomebymonthExport")
    public void incomebymonthExport(HttpServletRequest request,HttpServletResponse response){
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        Map<String, Object> params = getParams();
        try {
            //系统调用
            zlRpcResult = apiPayIncomeService.getPayIncomeByMonthExp(params);
        } catch (Exception ex) {
            logger.error("收单收益导出异常,输入参数 =" + params, ex);
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        if (!zlRpcResult.success()) {
            throw new ServiceException(zlRpcResult.getErrorMsg());
        }
        List<Map<String, Object>> paylist = (List<Map<String, Object>>)zlRpcResult.getData();
        if (paylist != null) {
            if (paylist.size() == 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("month", "暂无数据");
                paylist.add(map);
                String[] members = {"month", "paymethod", "spayrelamount", "sreturnmoney",
                        "sshouldpayamount", "shouldpayamount", "ssshouldpayamount"};
                String[] memberNames = {"日期", "收单方式", "有效收单金额", "有效退款金额", "有效收益基数（元）", "服务收益总额（元）",
                        "平台净收益总额（元）"};

                String menberName = "收单收益表";

                ExcelUtil.exportExcel(paylist, members, memberNames, menberName, request, response);

            } else {
                for (Map<String, Object> payMap : paylist) {
                    Map<String, Object> map = srvService.queryService(payMap);
                    String alirevenuescale = MapUtils.getString(map, "alirevenuescale");
                    String weixirevenuescale = MapUtils.getString(map, "weixirevenuescale");

                    String paymethod = MapUtils.getString(payMap, "paymethod");
                    String sshouldpayamount = MapUtils.getString(payMap, "sshouldpayamount");
                    Double payamount = 0.0;
                    if (!StringUtils.isEmpty(sshouldpayamount)) {
                        payamount = Double.parseDouble(sshouldpayamount);
                    }
                    if ("0".equals(paymethod)) {
                        if (!StringUtils.isEmpty(weixirevenuescale)) {
                            payMap.put("settlerate", weixirevenuescale);
                            Double weixirevenuescal = Double.parseDouble(weixirevenuescale);
                            Double b = ArithUtil.mul(payamount, weixirevenuescal);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("shouldpayamount", myRound(relmoney, 2));
                        } else {
                            payMap.put("settlerate", "0");
                            Double b = ArithUtil.mul(payamount, 0);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("shouldpayamount", myRound(relmoney, 2));
                        }

                    } else if ("1".equals(paymethod)) {
                        if (!StringUtils.isEmpty(alirevenuescale)) {
                            payMap.put("settlerate", alirevenuescale);
                            Double alibill = Double.parseDouble(alirevenuescale);
                            Double b = ArithUtil.mul(payamount, alibill);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("shouldpayamount", myRound(relmoney, 2));
                        } else {
                            payMap.put("settlerate", "0");
                            Double b = ArithUtil.mul(payamount, 0);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("shouldpayamount", myRound(relmoney, 2));
                        }
                    }
                }
            }
            if (paylist != null) {
                for (Map<String, Object> payMap : paylist) {
                    String paymethod = MapUtils.getString(payMap, "paymethod");
                    if ("0".equals(paymethod)) {
                        payMap.put("paymethod", "微信");
                    } else if ("1".equals(paymethod)) {
                        payMap.put("paymethod", "支付宝");
                    }
                }
                String[] members = {"month", "paymethod", "spayrelamount", "sreturnmoney",
                        "sshouldpayamount", "shouldpayamount", "ssshouldpayamount"};
                String[] memberNames = {"日期", "收单方式", "有效收单金额", "有效退款金额", "有效收益基数（元）", "服务收益总额（元）",
                        "平台净收益总额（元）"};

                String menberName = "收单收益表";

                ExcelUtil.exportExcel(paylist, members, memberNames, menberName, request, response);
            }
        }
    }
    /**
     * 收单收益明细
     * @param request
     * @return
     */
    @RequestMapping("/income/incomeByMonthDetail")
    public String incomeByMonthDetail(HttpServletRequest request){
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        Map<String, Object> params = getParams();

        try {
            //系统调用
            zlRpcResult = apiPayIncomeService.getPayIncomeByMonthDetail(params);
        } catch (Exception ex) {
            logger.error("获取收单收益明细异常,输入参数 =" + params, ex);
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
                        payMap.put("sshouldpayamount", relmoney);
                    }
                    else {
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("sshouldpayamount", relmoney);
                    }

                } else if ("1".equals(paymethod)) {
                    if(!StringUtils.isEmpty(alirevenuescale)){
                        payMap.put("settlerate", alirevenuescale);
                        Double alibill = Double.parseDouble(alirevenuescale);
                        Double b = ArithUtil.mul(payamount, alibill);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("sshouldpayamount", relmoney);
                    }
                    else {
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("sshouldpayamount", relmoney);
                    }
                }
            }
        }   request.setAttribute(Contants.PAGE_INFO, pageInfo);
        request.setAttribute("paymethod", params.get("paymethod"));
        request.setAttribute("month", params.get("month"));
        return "income/income_monthdetail";
    }
    @RequestMapping("/income/incomeByMonthDetailexport")
    public void incomeByMonthDetailexport(HttpServletRequest request,HttpServletResponse response) {
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        Map<String, Object> params = getParams();
        try {
            //系统调用
            zlRpcResult = apiPayIncomeService.getPayIncomeByMonthDetailExp(params);
        } catch (Exception ex) {
            logger.error("收单收益明细导出异常,输入参数 =" + params, ex);
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        if (!zlRpcResult.success()) {
            throw new ServiceException(zlRpcResult.getErrorMsg());
        }
        List<Map<String, Object>> paylist =( List<Map<String, Object>>) zlRpcResult.getData();
        if (paylist != null) {
            if (paylist.size() == 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("month", "暂无数据");
                paylist.add(map);
                String[] members = {"branchname", "shopname", "servername", "relpayamount",
                        "returnmoney", "settlerate", "sshouldpayamount", "shouldpayamount"};
                String[] memberNames = {"门店名称", "所属商户", "所属服务商", "有效收单金额（元）",
                        "有效退款金额（元）", "服务商收益比例", "服务收益总额（元)", "平台总收益（元)"};

                String menberName = "收单收益表";

                ExcelUtil.exportExcel(paylist, members, memberNames, menberName, request, response);

            } else {
                for (Map<String, Object> payMap : paylist) {
                    Map<String, Object> map = srvService.queryService(payMap);
                    String alirevenuescale = MapUtils.getString(map, "alirevenuescale");
                    String weixirevenuescale = MapUtils.getString(map, "weixirevenuescale");

                    String paymethod = MapUtils.getString(payMap, "paymethod");
                    String sshouldpayamount = MapUtils.getString(payMap, "shouldpayamount");
                    Double payamount = 0.0;
                    if (!StringUtils.isEmpty(sshouldpayamount)) {
                        payamount = Double.parseDouble(sshouldpayamount);
                    }
                    if ("0".equals(paymethod)) {
                        if (!StringUtils.isEmpty(weixirevenuescale)) {
                            payMap.put("settlerate", weixirevenuescale);
                            Double weixirevenuescal = Double.parseDouble(weixirevenuescale);
                            Double b = ArithUtil.mul(payamount, weixirevenuescal);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("shouldpayamount", myRound(relmoney, 2));
                        } else {
                            payMap.put("settlerate", "0");
                            Double b = ArithUtil.mul(payamount, 0);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("sshouldpayamount", myRound(relmoney, 2));
                        }

                    } else if ("1".equals(paymethod)) {
                        if (!StringUtils.isEmpty(alirevenuescale)) {
                            payMap.put("settlerate", alirevenuescale);
                            Double alibill = Double.parseDouble(alirevenuescale);
                            Double b = ArithUtil.mul(payamount, alibill);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("sshouldpayamount", myRound(relmoney, 2));
                        } else {
                            payMap.put("settlerate", "0");
                            Double b = ArithUtil.mul(payamount, 0);
                            Double relmoney = ArithUtil.mul(b, 0.01);
                            payMap.put("sshouldpayamount", myRound(relmoney, 2));
                        }
                    }
                }
            }
            if (paylist != null) {
                String[] members = {"branchname", "shopname", "servername", "relpayamount",
                        "returnmoney", "settlerate", "sshouldpayamount", "shouldpayamount"};
                String[] memberNames = {"门店名称", "所属商户", "所属服务商", "有效收单金额（元）",
                        "有效退款金额（元）", "服务商收益比例", "服务收益总额（元)", "平台总收益（元)"};

                String menberName = "收单收益表";

                ExcelUtil.exportExcel(paylist, members, memberNames, menberName, request, response);
            }
        }
    }
    private static double myRound(double number,int index){
        double result = 0;
        double temp = Math.pow(10, index);
        result = Math.round(number*temp)/temp;
        return result;}
}
