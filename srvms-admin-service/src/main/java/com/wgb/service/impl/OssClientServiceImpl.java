package com.wgb.service.impl;

import com.aliyun.oss.HttpMethod;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.OSSObject;
import com.aliyun.oss.model.ObjectMetadata;
import com.wgb.service.admin.OssClientService;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

/**
 * 阿里云图片上传
 *
 * @author fxs
 * @create 2018-05-23 11:08
 **/
public class OssClientServiceImpl implements OssClientService {


    @Autowired
    private OSSClient ossClient;

    private String bucketName;

    public String getBucketName() {
        return bucketName;
    }

    public void saveDocument(InputStream inputStream, String key, String contentType, Map<String, String> metadata) throws IOException {
        ObjectMetadata meta = new ObjectMetadata();
        // 设置上传内容类型
        meta.setContentType(contentType);
        // 上传文件
        ossClient.putObject(bucketName, key, inputStream, meta);
    }

    public String genUrlFromKey(String key) {
        String ret = key;
        if (!key.startsWith("http")) {
            URL url = ossClient.generatePresignedUrl(bucketName, key, DateUtils.add(new Date(), Calendar.YEAR, 1) ,HttpMethod.GET);
            int index = url.toString().lastIndexOf("?");
            ret = url.toString().substring(0, index);
        }
        return ret;
    }

    public String genUrlFromKey(String key, Date date) {
        String ret = key;
        if (!key.startsWith("http")) {
            URL url = ossClient.generatePresignedUrl(bucketName, key, date , HttpMethod.GET);
            int index = url.toString().lastIndexOf("?");
            ret = url.toString().substring(0, index);
        }
        return ret;
    }

    public void setBucketName(String bucketName) {
        this.bucketName = bucketName;
    }

    public OSSClient getOssClient() {
        return ossClient;
    }

    public void setOssClient(OSSClient ossClient) {
        this.ossClient = ossClient;
    }
}
