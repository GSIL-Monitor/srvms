package com.wgb.controller;

import com.wgb.bean.ZLResult;
import com.wgb.controller.entity.ResponseResultEntity;
import com.wgb.exception.BusinessException;
import com.wgb.exception.ServiceException;
import com.wgb.service.home.HomeService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 〈〉<br>
 * 〈功能详细描述〉
 *
 * @author wgb
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
@RequestMapping("home")
public class HomeController extends BaseController {

    @Autowired
    private HomeService homeService;

    private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);

    @RequestMapping("index")
    @ResponseBody
    public ZLResult home(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        Map<String, Object> params = getParams();
        try {
            Map<String ,Object> indexInfo = homeService.queryIndexInfo(params);
            result.setData(indexInfo);
        }catch (BusinessException ex){
            LOGGER.error("查询首页信息业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询首页信息系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("getExpireBranchCount")
    @ResponseBody
    public ZLResult getExpireBranchCount(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            int maturityStoreNums = homeService.getExpireBranchCount(params);
            result.setData(maturityStoreNums);
        } catch (BusinessException ex){
            LOGGER.error("查询到期门店业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询到期门店系统异常!",ex);
        }
        return result;
    }

    @RequestMapping("getStoreCount")
    @ResponseBody
    public ZLResult getStoreCount(HttpServletRequest request) {
        ZLResult result = ZLResult.Success();
        try {
            Map<String, Object> params = getParams();
            Map<String, Object> storeCount = homeService.getStoreCount(params);
            result.setData(storeCount);
        } catch (BusinessException ex){
            LOGGER.error("查询新增门店总数/流失门店数业务异常!",ex);
        }catch (Exception ex){
            LOGGER.error("查询新增门店总数/流失门店数系统异常!",ex);
        }
        return result;
    }


//    /**
//     * 获取环比增长率
//     *
//     * @param request
//     * @return
//     */
//
//    @RequestMapping("/getChainGrowthRate")
//    @ResponseBody
//    public Object getChainGrowthRate(HttpServletRequest request) {
//        Map<String, Object> params = getParams();
//        String newtime = MapUtils.getString(params, "newtime");
//        if (StringUtils.isEmpty(newtime)) {
//            throw new ServiceException(ServiceException.OPER_ERROR);
//        }
//        Map<String, Object> shopCountData = srvShopService.getChainGrowthRate(params);
//        if (shopCountData == null) {
//            throw new ServiceException(ServiceException.OPER_ERROR);
//        }
//
//        return shopCountData;
//    }

}
