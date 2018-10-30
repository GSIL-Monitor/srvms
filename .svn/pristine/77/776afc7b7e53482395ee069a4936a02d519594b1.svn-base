package com.wgb.service;

import com.wgb.service.workorder.OssClientService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fxs
 * @create 2018-07-11 14:32
 **/
@Service
public class FileUploadService {


    @Autowired
    private OssClientService ossClientService;

    public static Map<String ,String> FILE_TYPE;


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

    public String uploadImageFile(HttpServletRequest request , HttpServletResponse response)  {
        StringBuilder urls = new StringBuilder();
        try {
            List<MultipartFile> multipartFiles = null;
            if (request instanceof MultipartHttpServletRequest) {
                multipartFiles = ((MultipartHttpServletRequest) request).getFiles("upfiles");
            }
            if (multipartFiles.size() == 0 ){
                multipartFiles = ((MultipartHttpServletRequest) request).getFiles("file");
            }
            for (MultipartFile multipartFile : multipartFiles){
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
                urls.append(url + ",");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return urls.toString().substring(0 ,urls.length() - 1);
    }
}
