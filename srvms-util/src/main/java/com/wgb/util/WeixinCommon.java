package com.wgb.util;

import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/22 0022.
 */
public class WeixinCommon {

    /**
     * 获取网页授权凭证
     *
     * @param appId     公众账号的唯一标识
     * @param appSecret 公众账号的密钥
     * @param code
     * @return WeixinAouth2Token
     */
    public static Map<String, Object> getOauth2AccessToken(String appId, String appSecret, String code) {
        // 拼接请求地址
        String requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code";
        requestUrl = requestUrl.replace("APPID", appId);
        requestUrl = requestUrl.replace("SECRET", appSecret);
        requestUrl = requestUrl.replace("CODE", code);
        // 获取网页授权凭

        String httpResult = HttpClientUtil.httpGetRequest(requestUrl);

        System.out.println(httpResult);

        if (StringUtils.isNotEmpty(httpResult)) {
            try {
                JSONObject jsonObject = JSONObject.fromObject(httpResult);

                Map<String, Object> resultMap = new HashMap<String, Object>();
                resultMap.put("access_token", jsonObject.getString("access_token"));
                resultMap.put("expires_in", jsonObject.getString("expires_in"));
                resultMap.put("refresh_token", jsonObject.getString("refresh_token"));
                resultMap.put("openid", jsonObject.getString("openid"));
                resultMap.put("scope", jsonObject.getString("scope"));

                return resultMap;
            } catch (Exception e) {
                System.out.println("调用获取网页授权接口异常了:" + e.getMessage());
            }
        }

        return null;
    }

    /**
     * 通过网页授权获取用户信息
     *
     * @param accessToken 网页授权接口调用凭证
     * @param openId      用户标识
     * @return SNSUserInfo
     */
    @SuppressWarnings({"deprecation", "unchecked"})
    public static Map<String, Object> getUserInfo(String accessToken, String openId) {
        // 拼接请求地址
        String requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
        requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
        // 通过网页授权获取用户信息
        String httpResult = HttpClientUtil.httpGetRequest(requestUrl);

        System.out.println(httpResult);

        if (StringUtils.isNotEmpty(httpResult)) {
            try {

                String filterString = EmojiFilterUtils.filterEmoji(httpResult);
                JSONObject jsonObject = JSONObject.fromObject(filterString);
                Map<String, Object> resultMap = new HashMap<String, Object>();
                resultMap.put("openid", jsonObject.getString("openid"));
                resultMap.put("nickname", jsonObject.getString("nickname"));
                resultMap.put("sex", jsonObject.getString("sex"));
                resultMap.put("country", jsonObject.getString("country"));
                resultMap.put("province", jsonObject.getString("province"));
                resultMap.put("city", jsonObject.getString("city"));
                resultMap.put("headimgurl", jsonObject.getString("headimgurl"));
                return resultMap;
            } catch (Exception e) {
                System.out.println("调用获取微信用户信息接口异常了:" + e.getMessage());
            }
        }
        return null;
    }
}
