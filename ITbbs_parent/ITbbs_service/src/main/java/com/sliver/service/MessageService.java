package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.Message;

import java.util.List;

public interface MessageService {
	int sendMessage(String title, String content, Integer senderId, Integer receiverId);

	int sendMessage(String title, String content, Integer receiverId);

	int sendMessage(String Content, Integer receiverId);

	void receiveMessage(String messageId);

	void receiveMessages(List<String> messageIds);

	void receiveAllMessage(Integer userId);

	int deleteMessage(String messageId);

	int deleteMessages(List<String> messageIds);

	int deleteAllMessages(Integer userId);

	int countNotReadMessage(Integer userId);

	PageInfo<Message> list(PageInfo<Message> pageInfo, Integer id);
}
