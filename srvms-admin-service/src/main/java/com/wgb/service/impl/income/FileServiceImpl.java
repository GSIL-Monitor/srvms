package com.wgb.service.impl.income;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.service.income.FileService;
import com.wgb.util.CommonUtil;
import com.wgb.util.Contants;
import com.wgb.util.OssUtil;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class FileServiceImpl implements FileService {

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.FileServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Override
    public Map<String, Object> getFileInfo(String id) {

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);

        return dal.getReadOnlyDalClient().queryForMap(NAMESPACE + "getFileInfo", params);
    }

    @Override
    public void deleteFile(String fileId) {

        Map<String, Object> fileInfo = getFileInfo(fileId);
        String filePath = MapUtils.getString(fileInfo, "file_path", "");
        if (StringUtils.isNotEmpty(filePath)) {

            File file = new File(filePath);

            if (file.exists()) {
                file.delete();
            }

            Map<String, Object> params = new HashMap<String, Object>();
            params.put("fileId", fileId);

            dal.getDalClient().execute(NAMESPACE + "deleteFile", params);
        }
    }

    private String getRelativePath() {
        return "attachment" + "/" + CommonUtil.getCurrentYMDStr() + "/";
    }

    private String getNewFileName(String fileName) {
        //生成本地保存文件名前缀
        String fileNamePrefix = UUID.randomUUID().toString();
        //文件名后缀
        String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
        //新的文件名
        return fileNamePrefix + "." + fileNameSuffix;
    }

    private String saveFileLocal(MultipartFile file, HttpServletRequest request) {
        //系统根路径
        String sysBasePath = request.getSession().getServletContext().getRealPath("");
        //系统相对路径
        String relativePath = getRelativePath();
        //文件保存路径
        String savePath = sysBasePath + "/" + relativePath;
        //如果路径不存在，需要重新创建
        File savePathFile = new File(savePath);
        if (!savePathFile.exists()) {
            savePathFile.mkdirs();
        }
        //上传文件原名
        String fileName = file.getOriginalFilename();
        //新的文件名
        String newFileName = getNewFileName(fileName);
        //文件完整路径，含文件名
        String fileFullPath = savePath + newFileName;

        try {
            FileOutputStream outputStream = new FileOutputStream(fileFullPath);
            outputStream.write(file.getBytes());
            outputStream.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return relativePath + newFileName;
    }

    private String saveFileOss(MultipartFile file) {

        //上传文件原名
        String fileName = file.getOriginalFilename();
        //新的文件名
        String newFileName = getNewFileName(fileName);
        //文件的相对路径
        String relativeFilePath = getRelativePath() + newFileName;

        try {
            OssUtil.uploadFile2OSS(file.getInputStream(), relativeFilePath);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return relativeFilePath;
    }

    @Override
    public Map<String, Object> saveFile(MultipartFile file, Map<String, Object> params, HttpServletRequest request) {

        //上传文件原名
        String fileName = file.getOriginalFilename();
        //上传文件大小
        String fileSize = String.valueOf(file.getSize());

        /*String filePath = "";
        if (CommonUtil.isUseOss(CommonConfig.OSS_FLAG)) {
            filePath = saveFileOss(file);
        } else {
            filePath = saveFileLocal(file, request);
        }*/

        Map<String, Object> uploadParam = new HashMap<String, Object>();

        //新的文件名
        String newFileName = getNewFileName(fileName);
        //文件的相对路径
        String filePath = getRelativePath() + newFileName;

        uploadParam.put("name", fileName);
        uploadParam.put("size", fileSize);
        uploadParam.put(Contants.LOGIN_USER_ID, MapUtils.getString(params, Contants.LOGIN_USER_ID));
        uploadParam.put(Contants.LOGIN_USER_SHOP_CODE, MapUtils.getString(params, Contants.LOGIN_USER_SHOP_CODE));

        Map<String, Object> result = null;
//        try {
//            result = apiFileService.putObject(filePath, uploadParam,file.getInputStream());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
        return MapUtils.getMap(result, "result");
    }

    @Override
    public Page<?> queryFilePage(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "getFileList", params);
    }

    @Override
    public Page<?> queryPageList(Map<String, Object> params) {
        return dal.getReadOnlyDalClient().queryForListPage(NAMESPACE + "queryPageList", params);
    }

    @Override
    public Map<String, Object> postObjectPolicy(Map<String, Object> params) {
        return OssUtil.postObjectPolicy(MapUtils.getString(params, "shopcode"));
    }
}
