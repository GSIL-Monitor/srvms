/**
 * Copyright (C) 2017 FZJT Co. Ltd.
 *
 * @className:com.wgb.service.impl.changepsw.ChangePswServiceImpl
 * @description:
 * @version:v1.0.0
 * @author:Xiegf
 * Modification History:
 * Date                Author      Version     Description
 * -----------------------------------------------------------------
 * 2017年11月03日      Xiegf        v1.0.0        create
 */
package com.wgb.service.impl.changepwd;

import com.wgb.dao.CommonDalClient;
import com.wgb.service.changepwd.ChangePwdService;
import com.wgb.service.impl.BaseServiceImpl;
import com.wgb.util.MD5Util;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class ChangePwdServiceImpl extends BaseServiceImpl implements ChangePwdService {
    private static final String NAMESPACE = "shardName.com.wgb.service.impl.changepwd.ChangePwdServiceImpl.";

    @Autowired
    private CommonDalClient dal;

    @Override
    public String changePwd(Map<String, Object> params) {
        String oldPwdMD5Str = MD5Util.GetMD5Code(params.get("oldPassword").toString());
        params.put("oldPassword", oldPwdMD5Str);
        if (!checkPwd(params)) {
            return  "旧密码不正确！";
        }
        String newPwdMD5Str = MD5Util.GetMD5Code(params.get("newPassword").toString());
        params.put("newPassword", newPwdMD5Str);
        dal.getDalClient().execute(NAMESPACE + "updateObject", params);
        return "";
    }

    private boolean checkPwd(Map<String, Object> params){
        Map<String, Object> result =  dal.getDalClient().queryForMap(NAMESPACE + "queryOldPwd", params);
        String password = MapUtils.getString(result,"password");
        return StringUtils.equals(password, MapUtils.getString(params,"oldPassword",""));
    }
}
