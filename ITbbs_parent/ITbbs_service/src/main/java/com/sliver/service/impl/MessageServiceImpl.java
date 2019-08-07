package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.utils.IDUtils;
import com.sliver.common.utils.NullUtils;
import com.sliver.mapper.MessageMapper;
import com.sliver.pojo.Message;
import com.sliver.pojo.MessageExample;
import com.sliver.pojo.User;
import com.sliver.service.MessageService;
import com.sliver.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageMapper messageMapper;
    @Autowired
    private UserService userService;

    @Override
    public int sendMessage(String title,String content, Integer senderId, Integer receiverId) {
        if(NullUtils.isNull(title,content,senderId,receiverId)){
            return -1;
        }
        User sender = userService.getUserById(senderId);
        if(null == senderId){
            return -2;
        }
        User receiver = userService.getUserById(receiverId);
        if(null == receiver){
            return  -2;
        }
        Message message = new Message();
        message.setContent(content);
        message.setId(IDUtils.getUUID());
        message.setReceiverId(receiver.getId());
        message.setReceiver(receiver.getUsername());
        message.setSenderId(sender.getId());
        message.setSender(sender.getUsername());
        message.setSendTime(new Date());
        message.setTitle(title);
        message.setDeleted(false);
        message.setReaded(false);
        return messageMapper.insertSelective(message);
    }

    @Override
    public int sendMessage(String title, String content, Integer receiverId) {
        User admin = userService.getAdmin();
        return this.sendMessage(title,content,admin.getId(),receiverId);
    }

    @Override
    public int sendMessage(String content, Integer receiverId) {
        String title = "系统通知";
        return this.sendMessage(title,content,receiverId);
    }

    @Override
    public void receiveMessage(String messageId) {
        Message message = messageMapper.selectByPrimaryKey(messageId);
        if(null == message || message.getReceiveTime() != null){
            return;
        }
        message.setReaded(true);
        message.setReceiveTime(new Date());
        messageMapper.updateByPrimaryKeySelective(message);
    }

    @Override
    public void receiveMessages(List<String> messageIds) {
        MessageExample messageExample = new MessageExample();
        MessageExample.Criteria criteria = messageExample.createCriteria();
        criteria.andIdIn(messageIds);
        receive(messageExample);
    }

    @Override
    public void receiveAllMessage(Integer userId) {
        MessageExample messageExample = new MessageExample();
        MessageExample.Criteria criteria = messageExample.createCriteria();
        criteria.andReceiverIdEqualTo(userId);
        receive(messageExample);
    }

    private void receive(MessageExample messageExample){
        List<Message> messages = messageMapper.selectByExample(messageExample);
        Date now = new Date();
        for (Message m : messages) {
            m.setReaded(true);
            m.setReceiveTime(now);
        }
        messageMapper.updateBatchByPrimaryKeySelective(messages);
    }
    @Override
    public int deleteMessage(String messageId) {
        Message message = messageMapper.selectByPrimaryKey(messageId);
        if(null == message || message.getDeleted()){
            return -2;
        }
        message.setDeleted(true);
        message.setDeleteTime(new Date());
        return messageMapper.updateByPrimaryKeySelective(message);
    }

    @Override
    public int deleteMessages(List<String> messageIds) {
        MessageExample messageExample = new MessageExample();
        MessageExample.Criteria criteria = messageExample.createCriteria();
        criteria.andIdIn(messageIds);
        return  delete(messageExample);
    }

    @Override
    public int deleteAllMessages(Integer userId) {
        MessageExample messageExample = new MessageExample();
        MessageExample.Criteria criteria = messageExample.createCriteria();
        criteria.andReceiverIdEqualTo(userId);
        return  delete(messageExample);
    }

    @Override
    public int countNotReadMessage(Integer userId) {
        MessageExample example = new MessageExample();
        MessageExample.Criteria criteria = example.createCriteria();
        criteria.andReceiverIdEqualTo(userId);
        criteria.andReadedEqualTo(false);
        return messageMapper.countByExample(example);
    }

    private int delete(MessageExample messageExample){
        List<Message> messages = messageMapper.selectByExample(messageExample);
        for (Message m : messages) {
            m.setDeleted(true);
            m.setDeleteTime(new Date());
        }
        return messageMapper.updateBatchByPrimaryKeySelective(messages);
    }

    @Override
    public PageInfo<Message> list(PageInfo pageInfo, Integer id) {
        MessageExample example = new MessageExample();
        MessageExample.Criteria criteria = example.createCriteria();
        criteria.andDeletedEqualTo(false);
        criteria.andReceiverIdEqualTo(id);
        String orderBy = "readed asc,send_time desc";
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 20;
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<Message> list =  messageMapper.selectByExample(example);
        return new PageInfo<>(list);
    }
}
