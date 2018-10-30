package com.wgb.controller.income;

import com.wgb.controller.BaseController;
import com.wgb.dao.Page;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.exception.ServiceException;
import com.wgb.service.admin.OssClientService;
import com.wgb.service.dubbo.pays.admin.ApiImportBillService;
import com.wgb.service.dubbo.pays.admin.ApiPayIncomeService;
import com.wgb.util.Contants;
import com.wgb.util.ExcelReader;
import net.sf.json.JSONObject;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by 98721 on 2018/5/10.
 */
@Controller
@RequestMapping("/import")
public class ImportBillExcel extends BaseController {

    @Autowired
    private ApiImportBillService apiImportBillService;
    @Autowired
    private ApiPayIncomeService apiPayIncomeService;
    @Autowired
    private OssClientService ossClientService;

    @RequestMapping("/manage")
    public String manage(HttpServletRequest request) {
        Map<String, Object> params = getParams();

        return "income/import_manage";
    }
    private static String UPLOAD_FILE_IMAGE_NAME   = "OPS_IMAGE_";

    private static Map<String ,String> FILE_TYPE;

    static {
        FILE_TYPE = new HashMap<>();
        FILE_TYPE.put(".bmp" ,"image/bmp");
        FILE_TYPE.put(".gif" ,"image/gif");
        FILE_TYPE.put(".jpeg" ,"image/jpeg");
        FILE_TYPE.put(".jpg" ,"image/jpeg");
        FILE_TYPE.put(".png" ,"image/jpeg");
        FILE_TYPE.put(".html" ,"text/html");
        FILE_TYPE.put(".txt" ,"text/plain");
        FILE_TYPE.put(".vsd" ,"application/vnd.visio");
        FILE_TYPE.put(".pptx" ,"application/vnd.ms-powerpoint");
        FILE_TYPE.put(".ppt" ,"application/vnd.ms-powerpoint");
        FILE_TYPE.put(".docx" ,"application/msword");
        FILE_TYPE.put(".doc" ,"application/msword");
        FILE_TYPE.put(".xml" ,"text/xml");
    }

    @RequestMapping("/wxBillImport")
    public void wxBillImport(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {

        Map<String, Object> params = getParams();
        Map<String, Object> result = null;
        try {
            result=  billImport(file, params, request);
        } catch (ServiceException e) {
            result = new HashMap<String, Object>();
            result.put("success", "0");
            result.put("errorMsg", e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            result = new HashMap<String, Object>();
            result.put("success", "0");
            result.put("errorMsg", "导入失败");
            e.printStackTrace();
        }
        JSONObject jsonObject = JSONObject.fromObject(result);
        try {
            response.getWriter().write(jsonObject.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping("/uploadImageFile")
    public String uploadImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request ,HttpServletResponse response)  {
        ZLRpcResult rpcResult =new ZLRpcResult();
        ZLRpcResult    zlRpcResultForupdate=new ZLRpcResult();
        String url=null;

        Map<String, Object> params = getParams();
        try {
            String originalFilename = multipartFile.getOriginalFilename();
            int i = originalFilename.lastIndexOf(".");
            String substring = originalFilename.substring(i);

            String contentType = FILE_TYPE.get(substring);
            if(StringUtils.isBlank(contentType)){
                contentType = "image/jpeg";
            }
            InputStream inputStream = multipartFile.getInputStream();

            String stateKey = "ADMIN_MESSAGE_" + System.currentTimeMillis();
            //上传图片
            ossClientService.saveDocument( inputStream,stateKey ,contentType ,null);
            // 获取文件路径
            url = ossClientService.genUrlFromKey(stateKey);
            params.put("settlepic",url);
            try {
                //系统调用
                apiPayIncomeService.updatePicture(params);
            } catch (Exception ex) {
                //系统级别异常
                throw new ServiceException(ServiceException.SYS_ERROR);
            }
            if (!rpcResult.success()) {
                throw new ServiceException(rpcResult.getErrorMsg());
            }


            String callback = request.getParameter("callback");

            String result = "{\"name\":\""+ multipartFile.getOriginalFilename() +"\", \"originalName\": \""+ multipartFile.getOriginalFilename() +"\", \"size\": "+ multipartFile.getSize() +", \"state\": \"SUCCESS\", \"type\": \""+ multipartFile.getContentType() +"\", \"url\": \""+ stateKey +"\"}";

            result = result.replaceAll( "\\\\", "\\\\" );

            if( callback == null ){
                response.getWriter().print( result );
            }else{
                response.getWriter().print("<script>"+ callback +"(" + result + ")</script>");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            //系统调用
            zlRpcResultForupdate = apiPayIncomeService.getPayIncomeList(params);
        } catch (Exception ex) {
            //系统级别异常
            throw new ServiceException(ServiceException.SYS_ERROR);
        }
        //判断返回结果
        if (!zlRpcResultForupdate.success()) {
            throw new ServiceException(zlRpcResultForupdate.getErrorMsg());
        }
        Page pageInfo =(Page)zlRpcResultForupdate.getData();

        request.setAttribute(Contants.PAGE_INFO, pageInfo);
        return "income/member_manage";
    }


    @RequestMapping("/aliBillImport")
    public void aliBillImport(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {

        Map<String, Object> params = getParams();
        Map<String, Object> result = null;
        try {
            result=alibillImport(file, params, request);
        } catch (ServiceException e) {
            result = new HashMap<String, Object>();
            result.put("success", "0");
            result.put("errorMsg", e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            result = new HashMap<String, Object>();
            result.put("success", "0");
            result.put("errorMsg", "导入失败");
            e.printStackTrace();
        }
        JSONObject jsonObject = JSONObject.fromObject(result);
        try {
            response.getWriter().write(jsonObject.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public Map<String, Object> billImport(MultipartFile file, Map<String, Object> params, HttpServletRequest request) throws Exception {

        // 字段名数组
        String[] columns = {"month","mchid", "mchname", "payrelamount", "percent", "returnmoney", "returnpercent", "relpayamount", "Transactionno", "settlerate", "shouldpayamount"};

        // 模板标题
        String[] columnNames = { "奖励时间","特约商户号", "特约商户简称", "参与奖励交易金额(单位:元)", "参与奖励交易笔数", "参与奖励交易退款金额(单位:元)", "参与奖励退款笔数", "有效交易基数(单位:元)", "有效交易净笔数", "  奖励比例（%）", "奖励金额(单位:元)"};

        List<Map<String, Object>> dataList = ExcelReader.read(file.getInputStream(), columns, columnNames, 2);

        Map<String, Object> oneData = dataList.get(0);
        //校验是否已导入过此月数据
        Boolean comparemonth=compareMonth(oneData);
        if(!comparemonth){
            Map<String, Object> result = new HashMap<String, Object>();
            result.put("success", "0");
            result.put("errorMsg", "不能导入比当前月份更大月份的数据!");
            return result;
        }
        Map<String,Object> datas=exaimeMonth(oneData);
        if(MapUtils.isNotEmpty(datas)){
            Map<String, Object> result = new HashMap<String, Object>();
            result.put("success", "0");
            result.put("errorMsg", "已导入过该月份数据!");
            return result;
        }
        //成功数量
        int successCount = 0;

        for (Map<String, Object> data : dataList) {
            String success = MapUtils.getString(data, "success", "");
            if (success.equals("0")) {
                continue;
            }
            try {
                String  month=MapUtils.getString(data,"month");
                String newmonth=month.substring(0,4);
                String newmonth1=month.substring(6);
                if("月".equals(newmonth1)){
                    String newmonth4=month.substring(5).replace("月","");
                    String newmonth3=newmonth+"-"+"0"+newmonth4;
                    data.put("month",newmonth3);
                }
                else{
                    String newmonth4=month.substring(5,7);
                    String  newmonth3=newmonth+"-"+newmonth4;
                    data.put("month",newmonth3);
                }
                data.put("paymethod","0");
                data.put("settlestate","0");
                apiImportBillService.insertWxBill(data);
                data.put("success", "1");
                successCount++;
            } catch (ServiceException ex) {
                //当出现异常时，继续执行
                data.put("success", "0");
                data.put("errorMsg", ex.getMessage());
            } catch (Exception ex) {
                //当出现异常时，继续执行
                data.put("success", "0");
                data.put("errorMsg", "导入失败");
            }
        }

        List<Map<String, Object>> errorList = new ArrayList<Map<String, Object>>();
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("successCount", successCount);
        result.put("success", "1");
        return result;
    }
    public Map<String, Object> alibillImport(MultipartFile file, Map<String, Object> params, HttpServletRequest request) throws Exception {
        // 字段名数组
        String[] columns = {"month", "mchid", "mchname", "product",
                "branchcode", "branchname", "channel", "percent", "payamount",
                "payrelamount","Transactionno" ,"relmoney","relpayamount","returnpercent",
                "returnamount","returnmoney","paytype","paybase","mercontractrate",
                "settlerate","shouldpayamount","settlestatus"};

        // 模板标题
        String[] columnNames = {"业务周期", "商户PID", "商户名称", "商户产品",
                "门店ID/二级商户号", "门店名称/二级商户名称", "交易渠道类型", "交易笔数",
                " 交易金额（单位：元）", "交易实付金额（单位：元）","有效交易笔数", "有效交易金额（单位：元）",
                "有效交易实付金额（单位：元）","有效交易退款笔数",
                "有效交易退款金额（单位：元）","有效交易退款实付金额（单位：元）","结算依据类型","结算依据",
                "商户合约费率","结算费率","应结算总金额（单位：元）","结算状态"};

        List<Map<String, Object>> dataList = ExcelReader.read(file.getInputStream(), columns, columnNames, 2);

        Map<String, Object> oneData = dataList.get(0);
        //校验是否已导入过此月数据
        Map<String,Object> datas=exaimeMonth(oneData);
        Boolean comparemonth=compareMonth(oneData);
        if(!comparemonth){
            Map<String, Object> result = new HashMap<String, Object>();
            result.put("success", "0");
            result.put("errorMsg", "不能导入比当前月份更大月份的数据!");
            return result;
        }
        if(MapUtils.isNotEmpty(datas)){
            Map<String, Object> result = new HashMap<String, Object>();
            result.put("success", "0");
            result.put("errorMsg", "已导入过该月份数据!");
            return result;
        }
        //成功数量
        int successCount = 0;

        for (Map<String, Object> data : dataList) {
            String success = MapUtils.getString(data, "success", "");
            if (success.equals("0")) {
                continue;
            }
            try {
                String month =MapUtils.getString(data,"month");
                String newmonth=month.substring(0,4);
                String newmonth1=month.substring(4,6);
                String newmonth2=newmonth+"-"+newmonth1;
                data.put("month",newmonth2);
                data.put("paymethod","1");
                data.put("settlestate","0");
                apiImportBillService.insertAliBill(data);
                data.put("success", "1");
                successCount++;
            } catch (ServiceException ex) {
                //当出现异常时，继续执行
                data.put("success", "0");
                data.put("errorMsg", ex.getMessage());
            } catch (Exception ex) {
                //当出现异常时，继续执行
                ex.printStackTrace();
                data.put("success", "0");
                data.put("errorMsg", "导入失败");
            }
        }

        List<Map<String, Object>> errorList = new ArrayList<Map<String, Object>>();
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("successCount", successCount);
        result.put("success", "1");
        return result;
    }

    private Map<String, Object> exaimeMonth(Map<String, Object> data) {
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        //插入数据的年月
        String inserttime = MapUtils.getString(data, "month");
        String mchid=MapUtils.getString(data,"mchid");
        String submchid=mchid.substring(0,1);
        Map<String, Object> datatime = new HashMap<String, Object>();
        if("2".equals(submchid)){
            String newmonth=inserttime.substring(0,4);
            String newmonth1=inserttime.substring(4,6);
            String newmonth2=newmonth+"-"+newmonth1;
            datatime.put("month",newmonth2);
            datatime.put("paymethod","1");
        }
        else  if("1".equals(submchid)){
            String  month=MapUtils.getString(data,"month");
            String newmonth=month.substring(0,4);
            String newmonth1=month.substring(6);
            if("月".equals(newmonth1)){
                String newmonth4=month.substring(5).replace("月","");
                String newmonth3=newmonth+"-"+"0"+newmonth4;
                datatime.put("month",newmonth3);
                datatime.put("paymethod","0");
            }
            else{
                String newmonth4=month.substring(5,7);
                String  newmonth3=newmonth+"-"+newmonth4;
                datatime.put("month",newmonth3);
                datatime.put("paymethod","0");
            }
        }
        //查询表中是否已存在当前月份数据
        zlRpcResult = apiImportBillService.queryMonthBill(datatime);
        Map<String,Object> count=(Map)zlRpcResult.getData();
        return count;
    }
    private Boolean compareMonth(Map<String, Object> data)  throws  Exception{
        ZLRpcResult zlRpcResult = new ZLRpcResult();
        //插入数据的年月
        String inserttime = MapUtils.getString(data, "month");
        String mchid=MapUtils.getString(data,"mchid");
        String submchid=mchid.substring(0,1);
        Map<String, Object> datatime = new HashMap<String, Object>();
        if("2".equals(submchid)){
            String newmonth=inserttime.substring(0,4);
            String newmonth1=inserttime.substring(4,6);
            String newmonth2=newmonth+"-"+newmonth1;
            datatime.put("month",newmonth2);
            datatime.put("paymethod","1");
        }
        else  if("1".equals(submchid)){
            String  month=MapUtils.getString(data,"month");
            String newmonth=month.substring(0,4);
            String newmonth1=month.substring(6);
            if("月".equals(newmonth1)){
                String newmonth4=month.substring(5).replace("月","");
                String newmonth3=newmonth+"-"+"0"+newmonth4;
                datatime.put("month",newmonth3);
                datatime.put("paymethod","0");
            }
            else{
                String newmonth4=month.substring(5,7);
                String  newmonth3=newmonth+"-"+newmonth4;
                datatime.put("month",newmonth3);
                datatime.put("paymethod","0");
            }
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-mm");//设置日期格式
        String importmonth=(String) datatime.get("month");
        String systemmonth=df.format(new Date());
        Date bt=df.parse(importmonth);
        Date et=df.parse(systemmonth);
        boolean check=true;
        if(bt.equals(et)){
            check=true;
        }
        else if (bt.before(et)){
            check=true;
        }
        else if (bt.after(et)){
            check=false;
        }
        return check;
    }
}
