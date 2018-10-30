package com.wgb.service.impl.message;

import com.wgb.dao.CommonDalClient;
import com.wgb.dao.Page;
import com.wgb.exception.ServiceException;
import com.wgb.service.message.AdminMessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 运维消息
 *
 * @author fxs
 * @create 2018-05-22 15:16
 **/
@Service
public class AdminMessageServiceImpl implements AdminMessageService{

    private static final Logger LOGGER = LoggerFactory.getLogger(AdminMessageServiceImpl.class);

    private static final String NAME_SPACE  = "shardName.com.wgb.service.impl.message.AdminMessageServiceImpl.%s";

    @Autowired
    private CommonDalClient dalClient;


    public Page<?> queryAdminMessage(Map<String, Object> params) {
        try {
            return dalClient.getReadOnlyDalClient().queryForListPage(String.format(NAME_SPACE,"queryAdminMessage") ,params);
        } catch (Exception e){
            LOGGER.error("AdminMessageServiceImpl.queryAdminMessage 查询运维发送消息失败!",e);
            throw new ServiceException("查询运维发送消息失败!");
        }
    }

    public String updateMessageStatusById(Map<String, Object> params) {
        try {
           dalClient.getDalClient().execute(String.format(NAME_SPACE,"updateMessageStatusById") ,params);
           return "";
        } catch (Exception e){
            LOGGER.error("AdminMessageServiceImpl.updateMessageStatusById 发送消息失败!",e);
            throw new ServiceException("发送消息失败!");
        }
    }

    public String deleteMessageById(Map<String, Object> params) {
        try {
            dalClient.getDalClient().execute(String.format(NAME_SPACE,"deleteMessageById") ,params);
            return "";
        } catch (Exception e){
            LOGGER.error("AdminMessageServiceImpl.deleteMessageById 删除消息失败!",e);
            throw new ServiceException("删除消息失败!");
        }
    }

    public String updateMessageById(Map<String, Object> params) {

        try {
            dalClient.getDalClient().execute(String.format(NAME_SPACE,"updateMessageById") ,params);
            return "";
        } catch (Exception e){
            LOGGER.error("AdminMessageServiceImpl.deleteMessageById 删除消息失败!",e);
            throw new ServiceException("删除消息失败!");
        }
    }

    public String saveMessage(Map<String, Object> params) {
        try {
            dalClient.getDalClient().execute(String.format(NAME_SPACE,"saveMessage") ,params);
            return "";
        } catch (Exception e){
            LOGGER.error("AdminMessageServiceImpl.deleteMessageById 删除消息失败!",e);
            throw new ServiceException("删除消息失败!");
        }
    }

    public Map<String, Object> queryMessageDetail(Map<String, Object> params) {
        try {
            return dalClient.getReadOnlyDalClient().queryForMap(String.format(NAME_SPACE,"queryMessageDetail") ,params);
        } catch (Exception e){
            LOGGER.error("AdminMessageServiceImpl.queryAdminMessage 查询运维发送消息失败!",e);
            throw new ServiceException("查询运维发送消息失败!");
        }
    }
}
