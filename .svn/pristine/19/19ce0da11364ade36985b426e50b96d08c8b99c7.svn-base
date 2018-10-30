package com.wgb.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 解析JSON数据
 *  1. 解析JSON对象 {}
 *  2. 解析JSON数组 []
 */
public class JSONUtils {

    private static final Logger LOGGER = LoggerFactory.getLogger(JSONUtils.class);

    /**
     * 解析JSON对象
     * @param json
     *  JSON 数据，可以为JSONObject对象或者JSON数据格式的字符串
     * @return
     *  KEY -- VALUE 的形式，如果有JSON对象中包含JSON数组，返回值VALUE为LIST集合
     */
    public static Map<String, Object> parseJsonObject(Object json){
        Map<String, Object> result = new HashMap<>();
        JSONObject jsonObject = null;
        try {
            if(!(json instanceof  JSONObject)){
                jsonObject = JSON.parseObject(json.toString());
            }
            else {
                jsonObject = (JSONObject)json;
            }
            Set<String> keySet = jsonObject.keySet();
            for (String key : keySet){
                Object o = jsonObject.get(key);
                if(o instanceof JSONArray){
                    List<Object> jsonArray = parseJsonArray(o);
                    result.put(key,jsonArray);
                }else {
                    result.put(key,o);
                }
            }
        }catch (Exception e){
            LOGGER.error(String.format("JSON解析字符串异常!参数：%s",json),e);
            throw new RuntimeException(String.format("JSON解析字符串异常!参数：%s",json),e);
        }
        return result;
    }

    /**
     * 解析JSON数组
     * @param obj
     *     JSON数据，可以为JSONArray对象或者JSON数组字符串
     * @return
     *     list集合，如果JSON数组包含JSON对象，返回形式List<Map<String, Object>>
     */
    public static List<Object> parseJsonArray(Object obj){
        JSONArray jsonArray = null;
        List<Object> result = new ArrayList<>();
        try {
            if(!(obj instanceof JSONArray)) {
                jsonArray = JSON.parseArray(obj.toString());
            }
            else {
                jsonArray = (JSONArray) obj;
            }
            for (int index = 0 ; index < jsonArray.size();index++){
                Object o = jsonArray.get(index);
                if(o instanceof  JSONObject){
                    Map<String, Object> jsonObject = parseJsonObject(o);
                    result.add(jsonObject);
                }else {
                    result.add(o);
                }
            }
        }catch (Exception e){
            LOGGER.error(String.format("JSON解析异常!参数：%s",obj.toString()),e);
            throw new RuntimeException(String.format("JSON解析异常!参数：%s",obj.toString()),e);
        }
        return result;
    }
}
