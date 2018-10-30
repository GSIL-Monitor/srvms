package com.wgb.controller.income;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.BusinessException;
import com.wgb.service.income.ServiceIncomeService;
import com.wgb.util.ArithUtil;
import com.wgb.util.Contants;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/serviceincome")
public class ServiceIncomeController  extends BaseController {

    @Autowired
    private ServiceIncomeService serviceIncomeService;

    private static final Logger LOGGER = LoggerFactory.getLogger(ServiceIncomeController.class);

    @RequestMapping("/payincome/showShopTable")
    @ResponseBody
    public ZLResult showShopTable(HttpServletRequest request){
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Page<?> pageInfo = serviceIncomeService.showShopTable(params);
            result.setData(pageInfo);;
        }catch (BusinessException ex){
            LOGGER.error("查询对账单详情业务异常!" ,ex);
        }catch (Exception ex){
            LOGGER.error("查询对账单详情业务异常!" ,ex);
        }
        return result;
    }
}
