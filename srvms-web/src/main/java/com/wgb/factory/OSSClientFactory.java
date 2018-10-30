package com.wgb.factory;

import com.aliyun.oss.ClientConfiguration;
import com.aliyun.oss.OSSClient;

/**
 * 阿里云图片上传
 *
 * @author fxs
 * @create 2018-05-23 10:58
 **/
public class OSSClientFactory {


    private String endpoint;
    private String accessKeyId;
    private String accessKeySecret;

    public String getEndpoint() {
        return endpoint;
    }

    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public String getAccessKeyId() {
        return accessKeyId;
    }

    public void setAccessKeyId(String accessKeyId) {
        this.accessKeyId = accessKeyId;
    }

    public String getAccessKeySecret() {
        return accessKeySecret;
    }

    public void setAccessKeySecret(String accessKeySecret) {
        this.accessKeySecret = accessKeySecret;
    }

    public OSSClient getOSSClient(){
        ClientConfiguration conf = new ClientConfiguration();
        conf.setConnectionTimeout(15 * 1000); // 连接超时，默认15秒
        conf.setSocketTimeout(15 * 1000); // socket超时，默认15秒
        conf.setMaxConnections(5); // 最大连接数
        conf.setMaxErrorRetry(2); // 失败后最大重试次数，默认2次
        return new OSSClient( endpoint,  accessKeyId,  accessKeySecret ,conf);
    }
}
