package com.wgb.controller.aftersale;

import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.aftersale.AfterSaleService;
import com.wgb.service.srv.SrvService;
import com.wgb.service.srv.SrvShopService;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.Contants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.record.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by 98721 on 2018/3/14.
 */
@Controller
@RequestMapping("/aftersale")
public class AfterSaleRegController extends BaseController {
    @Autowired
    private AfterSaleService afterSaleService;

    /*
     *跳转售後页面
     */
    @RequestMapping("/manage")
    public String regAfterSale(HttpServletRequest request) {

        return "aftersale/aftersale_manage";
    }

    /*
     *售後页面列表
     */
    @RequestMapping("/aftermanage")
    public String aftermanage(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        //查所有人员列表
        Page<Map<String, Object>> pageInfo = afterSaleService.queryAfterSaleList(params);
        //查询所有省份
        List<Map<String, Object>> areas = afterSaleService.queryAllAreas(params);
        List<Map<String, Object>> list = pageInfo.getList();
        if (CollectionUtils.isNotEmpty(list)) {
            for (Map data : list) {
                //取出所管理省份
                String checkedArea = MapUtils.getString(data, "area", "");
                if (checkedArea.length() == 0) {
                    continue;
                }
                String[] area = checkedArea.split(",");
                String region = "";

                List<String> checkedAreaList = Arrays.asList(area);
                for (int i = 0; i < checkedAreaList.size(); i++) {
                    String id1 = checkedAreaList.get(i);
                    for (Map area0 : areas) {
                        String provienceid = MapUtils.getString(area0, "provienceid");
                        if (StringUtils.equals(provienceid, id1)) {
                            String region0 = MapUtils.getString(area0, "provience", "");
                            region = region + region0 + ',';
                        }
                    }
                }
                if (region.length() > 0) {
                    data.put("areaname", region.substring(0, region.length() - 1));
                }

            }
        }
        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "aftersale/aftersale_manage_detail";
    }

    /*
     *跳转到注册售后人员页面
     */
    @RequestMapping("/toReg")
    public String reg(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        List<Map<String, Object>> areas = afterSaleService.queryAreas(params);
        request.setAttribute("areaList", areas);
        return "aftersale/reg_aftersale";
    }

    /*
     *注册售后人员
     */
    @RequestMapping("/addReg")
    @ResponseBody
    public String addReg(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        //查询手机号是否已注册
        int count = afterSaleService.RegcheckAftersaleTel(params);
        if (count > 0) {
            throw new ServiceException("手机号已注册!");
        }
        //查询编号是否已注册
        int countId = afterSaleService.RegcheckAftersaleId(params);
        if (countId > 0) {
            throw new ServiceException("该人员编号已存在!");
        }
        //更新城市列表 售后人员信息
        String area = MapUtils.getString(params, "area");
        String[] areas = area.split(",");
        for (int i = 0; i < areas.length; i++) {
            params.put("useridArea", MapUtils.getString(params, "userid"));
            params.put("provienceid", areas[i]);
            params.put("statusArea", "1");
            afterSaleService.updateAreaInfo(params);
        }
        afterSaleService.addRegAfterSaler(params);

        return "";
    }

    /*
    *跳转修改页面
    */
    @RequestMapping("/toUpdate")
    public String toUpdate(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        //查询售后人员详细信息
        Map<String, Object> data = afterSaleService.queryAfterSaleDetails(params);
        //查询所有省份
        List<Map<String, Object>> areas = afterSaleService.queryAreas(params);

        //取出所管理省份
        String checkedArea = MapUtils.getString(data, "area", "");
        String[] area = checkedArea.split(",");
        List<String> checkedAreaList = Arrays.asList(area);
        for (Map area0 : areas) {
            area0.put("checked", 0);
            String provienceid = MapUtils.getString(area0, "provienceid");
            for (int i = 0; i < checkedAreaList.size(); i++) {
                String id1 = checkedAreaList.get(i);
                if (StringUtils.equals(provienceid, id1)) {
                    area0.put("checked", 1);
                }
            }
        }
        request.setAttribute("data", data);
        request.setAttribute("areaList", areas);
        return "aftersale/aftersale_update";
    }

    /*
     *修改
     */
    @RequestMapping("/updateAfterSale")
    @ResponseBody
    public String updateAfterSale(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        String userid = MapUtils.getString(params, "userid");
        String provience = MapUtils.getString(params, "provience");
        if (StringUtils.isEmpty(userid)) {
            throw new ServiceException("参数userid缺失!");
        }
        if (StringUtils.isEmpty(userid)) {
            throw new ServiceException("参数provience缺失!");
        }
        //查询手机号是否已注册
        int count = afterSaleService.checkAftersaleTel(params);
        if (count > 0) {
            throw new ServiceException("手机号已注册!");
        }

        //更新城市列表 售后人员信息
        String area = MapUtils.getString(params, "area");
        String[] areas = area.split(",");
        //更改后选中省
        List<String> checkedAreaList = Arrays.asList(areas);

        //更改后wei选中省
        List<String> uncheckedAreaListBefore = new ArrayList<>();

        //更改前选中省
        List<Map<String, Object>> selectedAreas = afterSaleService.queryAreasByUserid(params);

        List<String> checkedAreaListBefore = new ArrayList<>();

        for (Map are : selectedAreas) {
            checkedAreaListBefore.add(MapUtils.getString(are, "provienceid"));
        }

        if (checkedAreaListBefore.size() < checkedAreaList.size()) {
            //排除掉选中省
            for (int i = 0; i < checkedAreaList.size(); i++) {
                if (checkedAreaListBefore.contains(checkedAreaList.get(i))) {
                    checkedAreaListBefore.remove(checkedAreaList.get(i));
                }
            }
        } else {
            //排除掉选中省
            for (int i = 0; i < checkedAreaList.size(); i++) {
                if (checkedAreaListBefore.contains(checkedAreaList.get(i))) {
                    checkedAreaListBefore.remove(checkedAreaList.get(i));
                }
            }
        }

        //未选中省
        uncheckedAreaListBefore = checkedAreaListBefore;

        params.put("checkedAreaList", checkedAreaList);
        params.put("uncheckedAreaListBefore", uncheckedAreaListBefore);

        //更新选择省
        for (int i = 0; i < checkedAreaList.size(); i++) {
            params.put("useridArea", MapUtils.getString(params, "userid"));
            params.put("provienceid", checkedAreaList.get(i));
            params.put("statusArea", "1");
            afterSaleService.updateAreaInfo(params);
        }
        //更新未选择省
        for (int i = 0; i < uncheckedAreaListBefore.size(); i++) {
            params.put("useridArea", "");
            params.put("provienceid", uncheckedAreaListBefore.get(i));
            params.put("statusArea", "0");
            afterSaleService.updateAreaInfo(params);
        }

        afterSaleService.updateAfterSale(params);

        return "";
    }

    /*
     *禁用售后人员
     */
    @RequestMapping("/updateFlag")
    @ResponseBody
    public String updateFlag(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        //更改前选中省
        List<Map<String, Object>> selectedAreas = afterSaleService.queryAreasByUserid(params);

        //不禁用
        if (StringUtils.equals(MapUtils.getString(params, "status"), "1")) {
            if (CollectionUtils.isEmpty(selectedAreas)) {
                throw new ServiceException("请先为人员选择管理区域!");
            }
            afterSaleService.updateFlag(params);
        }

        //禁用时
        List<String> checkedAreaListBefore = new ArrayList<>();
        if (StringUtils.equals(MapUtils.getString(params, "status"), "0")) {

            afterSaleService.updateFlagAndArea(params);

            for (Map are : selectedAreas) {
                checkedAreaListBefore.add(MapUtils.getString(are, "provienceid"));
            }
            //更新选择省
            for (int i = 0; i < checkedAreaListBefore.size(); i++) {
                params.put("useridArea", "");
                params.put("provienceid", checkedAreaListBefore.get(i));
                params.put("statusArea", "0");
                afterSaleService.updateAreaInfo(params);
            }
        }

        return "";
    }
}
