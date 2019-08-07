package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.utils.IDUtils;
import com.sliver.mapper.PostReplyMapper;
import com.sliver.mapper.PostReplyVoMapper;
import com.sliver.pojo.PostReply;
import com.sliver.pojo.PostReplyVo;
import com.sliver.pojo.PostReplyVoExample;
import com.sliver.pojo.User;
import com.sliver.service.LogService;
import com.sliver.service.MessageService;
import com.sliver.service.PostReplyService;
import com.sliver.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class PostReplyServiceImpl implements PostReplyService {

    @Autowired
    PostReplyVoMapper postReplyVoMapper;
    @Autowired
    PostReplyMapper postReplyMapper;
    @Autowired
    UserService userService;
    @Autowired
    MessageService messageService;
    @Autowired
    LogService logService;
    @Override
    public PageInfo<PostReplyVo> listPostReplyBypostId(String postId,PageInfo pageInfo) {
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 6;
        String orderBy = "createtime desc";
        PostReplyVoExample example = new PostReplyVoExample();
        PostReplyVoExample.Criteria criteria = example.createCriteria();
        criteria.andPostIdEqualTo(postId);
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<PostReplyVo> postReplyVos = postReplyVoMapper.selectByExample(example);
        System.out.println(postReplyVos);
        return new PageInfo<>(postReplyVos);
    }

    @Override
    public int insert(PostReply postReply) {
        postReply.setCreatetime(new Date());
        postReply.setId(IDUtils.getUUID());
        return postReplyMapper.insertSelective(postReply);
    }

    @Override
    public int deleteByAdmin(String reason, String postReplyId, Integer userId) {
        PostReply postReply = postReplyMapper.selectByPrimaryKey(postReplyId);
        if(null == postReply){
            return -2;
        }
        User user = userService.getUserById(postReply.getUserId());
        StringBuilder content = new StringBuilder("管理员删除了你的回复:");
        content.append(postReply.getContent());
        StringBuilder logContent = new StringBuilder("管理员删除" + user.getUsername());
        logContent.append("的帖子回复");
        logContent.append(postReply);
        StringBuilder commonContent = new StringBuilder();
        commonContent.append("\n原因为:");
        commonContent.append(reason);
        logContent.append(commonContent);
        content.append(commonContent);
        messageService.sendMessage("删除通知",content.toString(),postReply.getUserId());
        logService.insert(logContent.toString());
        postReply.setDeleted(true);
        return postReplyMapper.updateByPrimaryKey(postReply);
    }

    @Override
    public int deleteByBoarder(String reason, String postReplyId, Integer userId) {
        PostReply postReply = postReplyMapper.selectByPrimaryKey(postReplyId);
        if(null == postReply){
            return -2;
        }
        User user = userService.getUserById(postReply.getUserId());
        StringBuilder content = new StringBuilder("版主"+user.getUsername()+"删除了你的回复:");
        content.append(postReply.getContent());
        StringBuilder logContent = new StringBuilder("管理员删除" + user.getUsername());
        logContent.append("的帖子回复");
        logContent.append(postReply);
        StringBuilder commonContent = new StringBuilder();
        commonContent.append("\n原因为:");
        commonContent.append(reason);
        logContent.append(commonContent);
        content.append(commonContent);
        messageService.sendMessage("删除通知",content.toString(),postReply.getUserId());
        logService.insert(logContent.toString());
        postReply.setDeleted(true);
        return postReplyMapper.updateByPrimaryKey(postReply);
    }
}
