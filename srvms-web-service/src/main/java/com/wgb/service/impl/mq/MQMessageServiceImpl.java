package com.wgb.service.impl.mq;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.rocketmq.MQStartJobAware;
import com.wgb.rocketmq.MQStartJobProxy;
import com.wgb.service.MQMessageService;
import com.wgb.util.Contants;
import com.wgb.util.RscUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2017/1/13.
 */
@Service
public class MQMessageServiceImpl implements MQMessageService, ApplicationContextAware {

    /**
     * 日志工具
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(MQMessageServiceImpl.class);

    private static final int THREE = 3;

    /**
     * 报文定时任务处理异常
     */
    private static final int FOUR = 4;

    /**
     * 最大长度
     */
    private static final int BEANIDMAXLENGTH = 128;

    /**
     * 错误原因最大长度
     */
    private static final int ERRORREASONMAXLENGTH = 16000000;

    private static final String COMMA = ",";

    /**
     * 报文数据操作备注最大长度
     */
    private static final int HUNDRED = 100;

    private static final String ERROR = "error";

    private static final String CLASSNAME = MQMessageServiceImpl.class.getName();

    @Autowired
    private CommonDalClient dal;

    private static final String NAMESPACE = "shardName.com.wgb.service.impl.mq.MQMessageServiceImpl.";

    public long insertMQMessage(String beanId, String message, String topic, String serviceName) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("beanid", checkDoubleByteCharacter(beanId, BEANIDMAXLENGTH));
        params.put("message", message);
        params.put("topic", topic);
        params.put("servicename", serviceName);

        String servernode = null;
        try {
            InetAddress addr = InetAddress.getLocalHost();
            servernode = addr.getHostAddress();
        } catch (UnknownHostException e) {
            LOGGER.error(MQMessageServiceImpl.class.getName() + ".insertMQMessage() UnknownHostException:"
                    + e.getMessage());
            servernode = "";
        }

        params.put("servernode", servernode);



        return dal.getDalClient().execute4PrimaryKey(NAMESPACE + "insertMQMessage", params).longValue();
    }

    public int updateMQMessageById(long messageid, int checkstatus, String errorreason) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("messageid", messageid);
        params.put("checkstatus", checkstatus);
        params.put("errorreason", checkDoubleByteCharacter(errorreason, ERRORREASONMAXLENGTH));


        return dal.getDalClient().execute(NAMESPACE + "updateMQMessageById", params);
    }

    public Map<String, Object> selectMQMessageById(long messageid) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("messageid", messageid);


        return dal.getDalClient().queryForMap(NAMESPACE + "selectMQMessageById", params);
    }

    public int deleteMQMessageById(long messageid) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("messageid", messageid);


        return dal.getDalClient().execute(NAMESPACE + "deleteMQMessageById", params);
    }

    public int updateMQMessageById(long messageid, int checkstatus, int isrepeat, String errorreason) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("messageid", messageid);
        params.put("checkstatus", checkstatus);
        params.put("isrepeat", isrepeat);
        params.put("errorreason", checkDoubleByteCharacter(errorreason, ERRORREASONMAXLENGTH));


        return dal.getDalClient().execute(NAMESPACE + "updateMQMessageById2", params);
    }

    public void chooseBusinessService(String beanId, Map<String, Object> messageMap) {
        // 参数判空
        if (StringUtils.isEmpty(beanId)) {
            throw new RuntimeException("chooseBusinessService:beanId is empty");
        }

        if (MapUtils.isEmpty(messageMap)) {
            throw new RuntimeException("chooseBusinessService: messageMap is empty");

        }
        // 根据beanId从Spring容器中获取job实例
        MQStartJobAware obj = (MQStartJobAware) (applicationContext.getBean(beanId));

        if (null == obj) {
            throw new RuntimeException("chooseBusinessService:MQStartJobAware obj is null");
        }

        // 回调执行业务方法
        MQStartJobProxy.invokeMethod(obj, messageMap);

    }

    /**
     * Spring容器
     */
    private ApplicationContext applicationContext;

    /**
     * 注入Spring容器
     */
    public void setApplicationContext(ApplicationContext applicationContext) {
        try {
            this.applicationContext = applicationContext;
        } catch (BeansException e) {
            LOGGER.error(MQMessageServiceImpl.class.getName() + ".setApplicationContext() BeansException:"
                    + e.getMessage());
            throw e;
        }
    }

    /**
     * 功能描述: <br>
     * 〈双字节字符处理〉
     *
     * @param str
     * @return
     * @see [相关类/方法](可选)
     * @since [产品/模块版本](可选)
     */
    private String checkDoubleByteCharacter(String str, int dbMaxLength) {
        // 参数判空
        if (null == str || dbMaxLength <= 0) {
            return "";
        }

        // 双字节字符正则表达式
        String regEx = "[^\\x00-\\xff]";
        Pattern p = Pattern.compile(regEx);
        Matcher m = p.matcher(str);

        // 统计双字节字符个数
        int doubleByteCount = 0;
        while (m.find()) {
            doubleByteCount++;
        }

        // 比较字符串与数据库字段长度(双字节字符*3)
        if ((doubleByteCount * THREE + (str.length() - doubleByteCount)) > dbMaxLength) {
            String newStr = m.replaceAll("?");
            return newStr.length() > dbMaxLength ? newStr.substring(0, dbMaxLength) : newStr;
        }

        return str;
    }

    public Page<?> selectXmlMessage(Map<String, Object> params) {



        Page<?> pageInfo = dal.getDalClient().queryForListPage(NAMESPACE + "queryXmlMessage", params);
        List<?> pageList = pageInfo.getList();
        if (null != pageList && 0 != pageList.size()) {
            List<Map<String, Object>> paramsList = (List<Map<String, Object>>) pageList;
            for (Map<String, Object> paramsMap : paramsList) {
                // 格式化報文信息字段
                String message = MapUtils.getString(paramsMap, "message", "");
                if (message.length() >= 60) {
                    String messagesome = message.substring(0, 60) + "...";
                    paramsMap.put("messagesome", messagesome);
                    // 若长度超过60，要格式化报文数据
                    String messageNew = formatXmlData(message);
                    paramsMap.put("message", messageNew);
                } else {
                    paramsMap.put("messagesome", message);
                }
                // 格式化错误信息字段
                String errorreason = MapUtils.getString(paramsMap, "errorreason", "");
                if (errorreason.length() >= 60) {
                    String errorreasonsome = errorreason.substring(0, 60) + "...";
                    paramsMap.put("errorreasonsome", errorreasonsome);
                }
            }
        }
        // }
        return pageInfo;
    }

    public String deleteXmlQuery(Map<String, Object> params) {

        // 获取报文id查询参数
        String messageids = MapUtils.getString(params, "messageids", "");
        // 获取操作备注与id关系
        Map<String, Object> operatecommentMap = getIdAndCommentsMap(messageids,
                MapUtils.getString(params, "operatecomments", ""));
        // 参数判空
        if (!checkMessageIds(messageids) || null == operatecommentMap) {
            return ERROR;
        }

        // 定义报文id查询参数Map
        Map<String, Object> idMap = new HashMap<String, Object>();
        idMap.put("messageids", messageids);

        idMap.put(Contants.SHARDNAME, Contants.DEFAULT_SHARDNAME);
        // 根据id组合查询报文数据
        List<Map<String, Object>> xmlMessagelist = dal.getDalClient().queryForList(NAMESPACE + "queryXmlMessage", idMap);
        // 报文数据判空及校验报文数目与备注数目是否一致
        if (null == xmlMessagelist || xmlMessagelist.isEmpty() || operatecommentMap.size() != xmlMessagelist.size()) {
            return ERROR;
        }

        // 遍历查询数据,插入报文异常日志表
        for (Map<String, Object> xmlMessageMap : xmlMessagelist) {
            // 遍历查询数据,插入报文异常日志表
            xmlMessageMap.put("operateip", MapUtils.getString(params, "operateip"));
            xmlMessageMap.put("operatetask", "后台人工操作");
            xmlMessageMap.put("operatestatus", "标记删除");
            xmlMessageMap.put("operateman", MapUtils.getString(params, Contants.LOGIN_USER_ID));
            xmlMessageMap.put("operatecomments", MapUtils.getString(operatecommentMap, MapUtils.getString(xmlMessageMap, "messageid")));

            xmlMessageMap.put(Contants.SHARDNAME, Contants.DEFAULT_SHARDNAME);
            dal.getDalClient().execute(NAMESPACE + "insertMQErrorMessageLog", xmlMessageMap);
        }


        idMap.put(Contants.SHARDNAME, Contants.DEFAULT_SHARDNAME);
        // 删除报文数据
        int count = dal.getDalClient().execute(NAMESPACE + "deleteMessageById", idMap);

        return count > 0 ? "success" : ERROR;
    }

    public String optXmlMessage(Map<String, Object> params) {
        // 获取报文id查询参数
        String messageids = MapUtils.getString(params, "messageids", "");
        // 获取操作备注与id关系
        Map<String, Object> operatecommentMap = getIdAndCommentsMap(messageids,
                MapUtils.getString(params, "operatecomments", ""));
        // 参数判空
        if (!checkMessageIds(messageids) || null == operatecommentMap) {
            return ERROR;
        }

        // 定义报文id查询参数Map
        Map<String, Object> idMap = new HashMap<String, Object>();
        idMap.put("messageids", messageids);

        idMap.put(Contants.SHARDNAME, Contants.DEFAULT_SHARDNAME);
        // 根据id组合查询报文数据
        List<Map<String, Object>> xmlMessagelist = dal.getDalClient().queryForList(NAMESPACE + "queryXmlMessage", idMap);
        // 报文数据判空及校验报文数目与备注数目是否一致
        if (CollectionUtils.isEmpty(xmlMessagelist) || operatecommentMap.size() != xmlMessagelist.size()) {
            return ERROR;
        }

        StringBuilder sb = new StringBuilder(1);

        // 遍历查询数据,执行处理报文数据,并插入报文异常日志表
        for (Map<String, Object> xmlMessageMap : xmlMessagelist) {
            long messageid = MapUtils.getLongValue(xmlMessageMap, "messageid");
            // 获取beanId
            String beanId = MapUtils.getString(xmlMessageMap, "beanid", "");
            // 获取报文内容
            String message = MapUtils.getString(xmlMessageMap, "message", "");

            if ("".equals(message)) {
                // 根据id更新报文表数据状态和异常消息
                updateMQMessageById(messageid, FOUR, "message is empty");
                // 记录处理失败的数据id
                sb.append(messageid).append(COMMA);
                // 执行下一个循环
                continue;
            }

            try {
                // 去除换行、回车、tab符
                message = message.replace("\r", "").replace("\n", "").replace("\t", "");
                // 解析报文字符串为Map
                Map<String, Object> messageMap = RscUtil.getMbfBody(message);
                messageMap.putAll(xmlMessageMap);
                // 解析处理报文数据
                chooseBusinessService(beanId, messageMap);

                // 插入报文异常日志数据
                xmlMessageMap.put("operateip", MapUtils.getString(params, "operateip"));
                xmlMessageMap.put("operatetask", "后台人工操作");
                xmlMessageMap.put("operatestatus", "执行成功");
                xmlMessageMap.put("operateman", MapUtils.getString(params, Contants.LOGIN_USER_ID));
                xmlMessageMap.put("operatecomments",
                        MapUtils.getString(operatecommentMap, messageid));


                xmlMessageMap.put(Contants.SHARDNAME, Contants.DEFAULT_SHARDNAME);
                dal.getDalClient().execute(NAMESPACE + "insertMQErrorMessageLog", xmlMessageMap);

                // 根据id删除报文表数据
                deleteMQMessageById(messageid);

            } catch (RuntimeException e) {
                // 获取异常信息
                String exceptionmessage = e.getMessage();
                // 日志打印异常信息
                LOGGER.error(CLASSNAME + ".optXmlMessage() RuntimeException:"
                        + exceptionmessage + "\n messageid = " + messageid);
                try {
                    // 根据id更新报文表数据状态和异常消息
                    updateMQMessageById(messageid, FOUR, e.getMessage());
                } catch (RuntimeException re) {
                    LOGGER.error(CLASSNAME + ".optXmlMessage() updateMQMessageById RuntimeException:"
                            + re.getMessage() + "\n messageid = " + messageid);
                }
                // 记录处理失败的数据id
                sb.append(messageid).append(COMMA);
            }
        }

        String returnStr = "success";
        if (sb.length() > 0) {
            String sbnew = sb.substring(0, sb.length() - 1);
            String[] sbnewArr = sbnew.split(",");
            if (xmlMessagelist.size() == sbnewArr.length) {
                returnStr = ERROR;
            } else {
                returnStr = sbnew;
            }
        }
        return returnStr;
    }

    private boolean checkMessageIds(String messageids) {
        if (StringUtils.isEmpty(messageids)) {
            return false;
        }

        Pattern p = Pattern.compile("^\\d{1,19}(\\,\\d{1,19}){0,500}$");

        return p.matcher(messageids).matches();
    }

    /**
     * 功能描述: <br>
     * 〈获取封装报文id和备注对应信息〉
     *
     * @param messageids
     * @param operatecomments
     * @return
     * @see [相关类/方法](可选)
     * @since [产品/模块版本](可选)
     */
    private Map<String, Object> getIdAndCommentsMap(String messageids, String operatecomments) {
        if (StringUtils.isEmpty(messageids) || StringUtils.isEmpty(operatecomments)) {
            return null;
        }

        String[] messageidsArr = messageids.split(COMMA);
        String[] operatecommentsArr = operatecomments.split(COMMA);
        int messageidsArrLength = messageidsArr.length;
        int operatecommentsArrLength = operatecommentsArr.length;

        if (0 == messageidsArrLength || 0 == operatecommentsArrLength
                || messageidsArrLength != operatecommentsArrLength) {
            return null;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        for (int i = 0; i < messageidsArrLength; i++) {
            map.put(messageidsArr[i],
                    operatecommentsArr[i].length() > HUNDRED ? operatecommentsArr[i].substring(0, HUNDRED)
                            : operatecommentsArr[i]);
        }

        return map;
    }

    /**
     * 功能描述: <br>
     * 〈格式化报文〉
     *
     * @param message
     * @return
     * @see [相关类/方法](可选)
     * @since [产品/模块版本](可选)
     */
    private String formatXmlData(String message) {
        String requestXML = message;
        SAXReader reader = new SAXReader();
        StringWriter stringWriter = new StringWriter();
        XMLWriter writer = null;
        Document document = null;
        OutputFormat format = new OutputFormat(" ", true);
        try {
            document = reader.read(new StringReader(message));
            writer = new XMLWriter(stringWriter, format);
            writer.write(document);
            writer.flush();
            requestXML = stringWriter.getBuffer().toString();
        } catch (DocumentException e) {
            // 日志打印异常信息
            LOGGER.error(MQMessageServiceImpl.class.getName() + ".formatXmlData() Exception:" + e.getMessage());
        } catch (IOException e) {
            // 日志打印异常信息
            LOGGER.error(MQMessageServiceImpl.class.getName() + ".formatXmlData() Exception:" + e.getMessage());
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    // 日志打印异常信息
                    LOGGER.error(MQMessageServiceImpl.class.getName() + ".formatXmlData() Exception:"
                            + e.getMessage());
                }
            }
        }

        return requestXML;
    }
}
