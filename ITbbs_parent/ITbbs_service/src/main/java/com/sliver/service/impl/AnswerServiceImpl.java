package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.utils.IDUtils;
import com.sliver.mapper.AnswerMapper;
import com.sliver.mapper.AnswerVoMapper;
import com.sliver.mapper.ScoreLogMapper;
import com.sliver.pojo.*;
import com.sliver.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class AnswerServiceImpl implements AnswerService {
    @Autowired
    private AnswerMapper answerMapper;
    @Autowired
    private UserService userService;
    @Autowired
    private QuestionService questionService;
    @Autowired
    private AnswerVoMapper answerVoMapper;
    @Autowired
    private LogService logService;
    @Autowired
    private ScoreLogService scoreLogService;
    @Autowired
    private MessageService messageService;

    @Override
    public PageInfo<AnswerVo> listAnswerByQuestionId(String questionId, PageInfo pageInfo) {
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 6;
        String orderBy = "createtime desc";
        AnswerVoExample example = new AnswerVoExample();
        AnswerVoExample.Criteria criteria = example.createCriteria();
        criteria.andQuestionIdEqualTo(questionId);
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<AnswerVo> postReplyVos = answerVoMapper.selectByExample(example);
        System.out.println(postReplyVos);
        return new PageInfo<>(postReplyVos);
    }

    @Override
    public Answer getAnswerById(String answerId) {
        return answerMapper.selectByPrimaryKey(answerId);
    }

    @Override
    public int insert(Answer answer) {
        answer.setId(IDUtils.getUUID());
        answer.setCreatetime(new Date());
        // 向提问者发送信息
        Question question = questionService.getQuestionById(answer.getQuestionId());
        if(null == question){
            return  -1;
        }
        messageService.sendMessage("问题回复","有人回答了你的问题："+question.getTitle()+"，快去看看吧",question.getUserId());
        return  answerMapper.insert(answer);
    }

    @Override
    public void ackAnswer(Answer answer, Question question) {
        question.setAckAnswerTime(new Date());
        question.setUsefulAnswerId(answer.getId());
        final int i = questionService.update(question);
        // 增加积分
        answer = answerMapper.selectByPrimaryKey(answer.getId());
        User user = userService.getUserById(answer.getUserId());
        user.setScore(user.getScore() + question.getPayScore());
        userService.update(user);
        // 记录日志
        String content = user +"回答问题：" + question + "答案："+answer;
        logService.insert(content);
        // 记录积分日志
        scoreLogService.insert("回答被确认",question.getPayScore(),user.getId());
    }
}
