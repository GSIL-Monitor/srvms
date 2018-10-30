package com.wgb.controller.upload;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.wgb.controller.BaseController;
import com.wgb.service.admin.OssClientService;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * 文件上传
 *
 * @author fxs
 * @create 2018-05-23 9:23
 **/
@Controller
@RequestMapping("upload")
public class FileUploadController extends BaseController{


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


    @Autowired
    private OssClientService ossClientService;

    @RequestMapping("controller")
    public void imageUpload(HttpServletRequest request , HttpServletResponse response){

        Map<String, Object> params = getParams();
        String action = MapUtils.getString(params, "action");
        if("uploadimage".equalsIgnoreCase(action)){
            uploadImageFile(request ,response);
        }else{
            org.springframework.core.io.Resource res = new ClassPathResource("config.json");
            InputStream is = null;
            response.setHeader("Content-Type" , "text/html");
            try {
                is = new FileInputStream(res.getFile());
                StringBuffer sb = new StringBuffer();
                byte[] b = new byte[1024];
                int length=0;
                while(-1!=(length=is.read(b))){
                    sb.append(new String(b,0,length,"utf-8"));
                }
                String result = sb.toString().replaceAll("/\\*(.|[\\r\\n])*?\\*/","");
                JSONObject json = JSON.parseObject(result);
                PrintWriter out = response.getWriter();
                out.print(json.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }

    private String uploadImageFile(HttpServletRequest request ,HttpServletResponse response)  {

        try {
            MultipartFile multipartFile = null;
            if (request instanceof MultipartHttpServletRequest) {
                multipartFile = ((MultipartHttpServletRequest) request).getFile("upfile");
            }
            String originalFilename = multipartFile.getOriginalFilename();
            int i = originalFilename.lastIndexOf(".");
            String substring = originalFilename.substring(i);

            String contentType = FILE_TYPE.get(substring);
            if(StringUtils.isBlank(contentType)){
                contentType = "image/jpeg";
            }
            InputStream inputStream = multipartFile.getInputStream();

            String stateKey = "admin_message_" + System.currentTimeMillis() +"/" + originalFilename;
            //上传图片
            ossClientService.saveDocument( inputStream,stateKey ,contentType ,null);
            // 获取文件路径
            String url = ossClientService.genUrlFromKey(stateKey);
            String callback = request.getParameter("callback");

            String result = "{\"name\":\""+ multipartFile.getOriginalFilename() +"\", \"originalName\": \""+ multipartFile.getOriginalFilename() +"\", \"size\": "+ multipartFile.getSize() +", \"state\": \"SUCCESS\", \"type\": \""+ multipartFile.getContentType() +"\", \"url\": \""+ url +"\"}";

            result = result.replaceAll( "\\\\", "\\\\" );

            if( callback == null ){
                response.getWriter().print( result );
            }else{
                response.getWriter().print("<script>"+ callback +"(" + result + ")</script>");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

}
