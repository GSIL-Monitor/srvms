package com.wgb.service.income;

import com.wgb.dao.Page;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface FileService {

    /**
     * 获得文件信息
     * @param fileId
     * @return
     */
    Map<String, Object> getFileInfo(String fileId);

    /**
     * 删除文件
     * @param fileId
     */
    void deleteFile(String fileId);

    /**
     * 保存文件
     * @param file
     * @param params
     * @param request
     * @return
     */
    Map<String, Object> saveFile(MultipartFile file, Map<String, Object> params, HttpServletRequest request);

    /**
     * 查询文件页面
     * @param params
     * @return
     */
    Page<?> queryFilePage(Map<String, Object> params);

    /**
     * 查询文件列表
     * @param params
     * @return
     */
    Page<?> queryPageList(Map<String, Object> params);

    /**
     * 请求对象策略
     * @param params
     * @return
     */
    Map<String,Object> postObjectPolicy(Map<String, Object> params);
}
