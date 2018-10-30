package com.wgb.controller.renew;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.renew.ExtendService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
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

/**
 * 延长试用期
 *
 * @author fxs
 * @create 2018-09-11 11:01
 **/
@Controller
@RequestMapping("renew/extend")
public class ExtendController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(ExtendController.class);
    @Autowired
    private ExtendService service;

    /**
     * 延期列表跳转页面
     * @param request
     * @return
     */
    @RequestMapping("extendManage.action")
    public String extendManage(HttpServletRequest request){
        return "renew/extend_manage";
    }

    @RequestMapping("queryExtendInfoList.action")
    public String queryExtendInfoList(HttpServletRequest request){
        Map<String, Object> params = getParams();
        LOGGER.info("查询订单信息列表入参： {}" ,params);
        try {

            // 查询订单信息
            Page pageInfo = service.queryExtendInfoByCondition(params);
            request.setAttribute("pageInfo" ,pageInfo);
            return "renew/extend_manage_table";
        }catch (ServiceException e){
            LOGGER.error("查询订单信息列表业务异常!errorMessage：" ,e );
            return "error";
        }catch (Exception ex){
            LOGGER.error("查询订单信息列表失败!errorMessage：" ,ex);
            return "error";
        }
    }

    /**
     * 跳转延期页面
     * @return
     */
    @RequestMapping("jumpShopExtend.action")
    public String jumpShopExtend(){
        return "renew/shop_extend";
    }

    @RequestMapping("saveExtendInfo.action")
    @ResponseBody
    public ZLResult saveExtendInfo(){
        ZLResult zlResult = ZLResult.Success();
        Map<String, Object> params = getParams();
        boolean checkResult = checkSaveExtendInfoParams(params);
        if(!checkResult){
            zlResult = ZLResult.Error("缺失参数extendInfo参数!");
        }
        try {
            service.saveExtendInfo(params);
            zlResult.setData("操作成功！");
        }catch (ServiceException e){
            LOGGER.error("保存延期信息业务异常!errorMessage：" ,e );
            zlResult = ZLResult.Error("保存延期信息业务异常!请联系管理员!");
        }catch (Exception ex){
            LOGGER.error("保存延期信息失败!errorMessage：" ,ex);
            zlResult = ZLResult.Error("保存延期信息业务异常!请联系管理员!");
        }
        return zlResult;
    }

    private boolean checkSaveExtendInfoParams(Map<String, Object> params) {
        String extendInfo = MapUtils.getString(params, "extendInfo");
        if(StringUtils.isBlank(extendInfo)){
            return false;
        }
        return true;
    }

    @RequestMapping("queryExtendDetail.action")
    public String queryExtendDetail(HttpServletRequest request){
        try {
            Map<String, Object> params = getParams();
            List<Map<String,Object>> extendInfoList = service.queryExtendDetail(params);
            request.setAttribute("extendInfoList" ,extendInfoList);
            request.setAttribute("shopcode" ,MapUtils.getString(params ,"shopcode"));
            request.setAttribute("branchcode" ,MapUtils.getString(params ,"branchcode"));
        }catch (ServiceException e){
            LOGGER.error("保存延期信息业务异常!errorMessage：" ,e );
            return "error";
        }catch (Exception ex){
            LOGGER.error("保存延期信息失败!errorMessage：" ,ex);
            return "error";
        }
        return "/renew/extend_detail";
    }
}
