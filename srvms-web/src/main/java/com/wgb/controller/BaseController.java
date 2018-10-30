package com.wgb.controller;

import com.wgb.bean.ZLResult;
import com.wgb.dubbo.ZLRpcResult;
import com.wgb.service.srv.SrvUserService;
import com.wgb.util.ApiUtil;
import com.wgb.util.ParamsUtil;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * Controller通用父类
 */
@Controller
@Qualifier("baseController")
public abstract class BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(BaseController.class);

    @Autowired
    private SrvUserService srvUserService;

    public Map<String, Object> getParams() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Map<String, Object> params = ParamsUtil.getParams(request, getUserInfo(request));
        return params;
    }

    /**
     * 获取当前登录用户信息
     *
     * @param request
     * @return
     */
    public Map<String, Object> getUserInfo(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userInfo");
        String username = MapUtils.getString(userInfo, "account");
        if (StringUtils.isEmpty(username)) {
            return null;
        }
        return srvUserService.getCurUserInfo(username);
    }

    public Map<String, Object> SuccessResult(Object data) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("success", "1");
        result.put("data", data);
        ApiUtil.formatObjectForApi(result);
        return result;
    }

    /**
     * 返回结果为字符串类型，且字符串是一个提示语
     * @param rpcResult
     * @return
     */
    public ZLResult parseRpcResultForMessage(ZLRpcResult rpcResult){
        if (null == rpcResult){
            LOGGER.info("调用RPC，未返回RPC调用结果！");
            return ZLResult.Error("系统异常，请联系管理员!");
        }
        ZLResult result;
        if(rpcResult.success()){
            if( null != rpcResult.getData() && StringUtils.isNotBlank(rpcResult.getData().toString())){
                result = ZLResult.Error(rpcResult.getData().toString());
            }else{
                result = ZLResult.Success();
            }
        } else{
            result = ZLResult.Error(rpcResult.getErrorMsg());
        }
        return result;
    }

    /**
     * 返回结果，为数据
     * @param rpcResult
     * @return
     */
    public ZLResult parseRpcResultForData(ZLRpcResult rpcResult){
        if (null == rpcResult){
            LOGGER.info("调用RPC，未返回RPC调用结果！");
            return ZLResult.Error("系统异常，请联系管理员!");
        }
        ZLResult result;
        if(rpcResult.success()){
            result = ZLResult.Success(rpcResult.getData());
        } else{
            result = ZLResult.Error(rpcResult.getErrorMsg());
        }
        return result;
    }

    /**
     *  上传图片参数转换
     * @return
     */
    protected Map<String ,Object> getUploadParams(Map<String ,Object> parameterMap){
        Map<String ,Object> result = new HashMap<>();
        for (Map.Entry<String ,Object> entry : parameterMap.entrySet()){
            Object value = entry.getValue();
            if ((value instanceof String[]) && ((String[]) value).length == 1){
                result.put(entry.getKey() ,((String[])value)[0].toString());
            }else {
                result.put(entry.getKey() ,value);
            }
        }
        return result;
    }

}
