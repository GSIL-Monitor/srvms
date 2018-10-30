package com.wgb.service.impl.income;

import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.dubbo.pays.admin.ApiPayIncomeService;
import com.wgb.service.income.ServiceIncomeService;
import com.wgb.service.srv.PubSrvService;
import com.wgb.util.ArithUtil;
import com.wgb.util.Contants;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.record.pivottable.PageItemRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-09-30 15:20
 **/
@Service
public class ServiceIncomeServiceImpl implements ServiceIncomeService {

    @Autowired
    private ApiPayIncomeService apiPayIncomeService;
    @Autowired
    private PubSrvService pubSrvService;


    public Page<?> showShopTable(Map<String, Object> params) {
        ZLRpcResult rpcResult = apiPayIncomeService.getServicePayIncomeList(params);
        Page pageInfo = (Page)rpcResult.getData();
        List<Map<String, Object>>  paylist = pageInfo.getList();
        if (paylist != null){
            for (Map<String, Object> payMap : paylist) {
                payMap.put("servercode",params.get("servercode"));
                Map<String, Object>     map = pubSrvService.queryService(payMap);
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
                        payMap.put("sshouldpayamount",myRound(relmoney,2));
                    }
                    else{
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("sshouldpayamount", myRound(relmoney,2));

                    }
                }
                else if ("1".equals(paymethod)) {
                    if(!StringUtils.isEmpty(alirevenuescale)){
                        payMap.put("settlerate", alirevenuescale);
                        Double alibill = Double.parseDouble(alirevenuescale);
                        Double b = ArithUtil.mul(payamount, alibill);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("sshouldpayamount", myRound(relmoney,2));
                    }
                    else{
                        payMap.put("settlerate", "0");
                        Double b = ArithUtil.mul(payamount, 0);
                        Double relmoney = ArithUtil.mul(b, 0.01);
                        payMap.put("sshouldpayamount", myRound(relmoney,2));
                    }
                }
            }
        }
       return pageInfo;
    }

    //保留两位小数
    private static double myRound(double number,int index){
        double result = 0;
        double temp = Math.pow(10, index);
        result = Math.round(number*temp)/temp;
        return result;
    }
}
