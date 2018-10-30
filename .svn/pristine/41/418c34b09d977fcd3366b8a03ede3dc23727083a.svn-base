package com.wgb.service.workorder;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Map;

/**
 * 阿里云图片上传
 *
 * @author fxs
 * @create 2018-05-23 11:07
 **/
public interface OssClientService {

    /**
     * 保存文件
     * @param inputStream
     * @param key
     * @param contentType
     * @param metadata
     * @throws IOException
     */
    void saveDocument(InputStream inputStream, String key, String contentType, Map<String, String> metadata) throws IOException;

    /**
     *  生成地址的key
     * @param key
     * @return
     */
    String genUrlFromKey(String key);

    String genUrlFromKey(String key, Date date);

}
