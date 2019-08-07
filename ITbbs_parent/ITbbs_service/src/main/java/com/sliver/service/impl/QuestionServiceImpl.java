package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.IDUtils;
import com.sliver.mapper.AnswerMapper;
import com.sliver.mapper.QuestionMapper;
import com.sliver.mapper.QuestionVoMapper;
import com.sliver.mapper.UserMapper;
import com.sliver.pojo.*;
import com.sliver.service.LogService;
import com.sliver.service.QuestionService;
import com.sliver.service.ScoreLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 问题service
 * @author LIN
 */
@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionMapper questionMapper;
    @Autowired
    private AnswerMapper answerMapper;
    @Autowired
    private QuestionVoMapper questionVoMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private LogService logService;
    @Autowired
    private ScoreLogService scoreLogService;
    @Override
    public BBSResult insert(Question question) {
        if(null == question.getUserId() || null == question.getTitle()
                || null == question.getContent() || null == question.getPayScore()){
            return BBSResult.build(555,"必填字段不能为空！");
        }
        User user = userMapper.selectByPrimaryKey(question.getUserId());
        if(user == null){
            return BBSResult.build(554,"请刷新页面后重试！");
        }
        if(question.getPayScore() > user.getScore()){
            return  BBSResult.build(553,"积分不足，无法发布");
        }
        // 扣除积分
        user.setScore(user.getScore() - question.getPayScore());
        // 增加提问数
        user.setQuestionNum(user.getQuestionNum() + 1);
        // 写日志
        logService.insert("用户"+user + "发布问题:"+question + "悬赏积分" + question.getPayScore());
        scoreLogService.insert("发布问题："+ question.getTitle(),question.getPayScore(), question.getUserId());
        //  将数据写入数据库
        userMapper.updateByPrimaryKeySelective(user);
        question.setCreatetime(new Date());
        question.setDeleted(false);
        question.setId(IDUtils.getUUID());
        int i = questionMapper.insertSelective(question);
        return BBSResult.ok(i);
    }

    @Override
    public int update(Question question) {
        return questionMapper.updateByPrimaryKeySelective(question);
    }

    @Override
    public int delete(String questionId) {
        Question q = questionMapper.selectByPrimaryKey(questionId);
        q.setDeleted(true);
        // 记录日志
        logService.insert("用户删除问题:"+q);
        int i = questionMapper.updateByPrimaryKeySelective(q);
        return i;
    }


    @Override
    public QuestionVo getQuestionVoById(String questionId) {
        QuestionVoExample example = new QuestionVoExample();
        QuestionVoExample.Criteria criteria = example.createCriteria();
        criteria.andIdEqualTo(questionId);
        List<QuestionVo> questionVos = questionVoMapper.selectByExample(example);
        if(null!= questionVos &&questionVos.size() > 0)
        {
            return  questionVos.get(0);
        }else{
            return  null;
        }
    }

    @Override
    public Question getQuestionById(String questionId) {
        return questionMapper.selectByPrimaryKey(questionId);
    }

    @Override
    public PageInfo<Question> list(PageInfo pageInfo) {
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 10;
        QuestionExample example = new QuestionExample();
        QuestionExample.Criteria criteria = example.createCriteria();
        criteria.andDeletedEqualTo(false);
        String orderBy = "createtime desc";
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<Question> list =  questionMapper.selectByExample(example);
        return new PageInfo<>(list);
    }

    @Override
    public PageInfo<Question> listByUserId(int userId, PageInfo pageInfo) {
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 10;
        QuestionExample example = new QuestionExample();
        QuestionExample.Criteria criteria = example.createCriteria();
        criteria.andDeletedEqualTo(false);
        criteria.andUserIdEqualTo(userId);
        String orderBy = "createtime desc";
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<Question> list =  questionMapper.selectByExample(example);
        return new PageInfo<>(list);
    }

    @Override
    public PageInfo<Question> listQuestionByAnswers(User user, PageInfo pageInfo) {
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 10;
        AnswerExample answerExample = new AnswerExample();
        AnswerExample.Criteria criteria = answerExample.createCriteria();
        criteria.andUserIdEqualTo(user.getId());
        List<Answer> answers = answerMapper.selectByExample(answerExample);
        List<String> answerIdList = new ArrayList<>();
        for (Answer a:
             answers) {
            answerIdList.add(a.getId());
        }
        QuestionExample questionExample = new QuestionExample();
        QuestionExample.Criteria questionExampleCriteria = questionExample.createCriteria();
        questionExampleCriteria.andUsefulAnswerIdIn(answerIdList);
        String orderBy = "createtime desc";
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<Question> list =  questionMapper.selectByExample(questionExample);
        return  new PageInfo<>(list);
    }
}
