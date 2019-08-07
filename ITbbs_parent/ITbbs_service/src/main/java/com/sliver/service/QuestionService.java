package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSResult;
import com.sliver.pojo.Question;
import com.sliver.pojo.QuestionVo;
import com.sliver.pojo.User;

import java.util.List;

public interface QuestionService {
    BBSResult insert(Question question);
    int update(Question question);
    int delete(String questionId);
    QuestionVo getQuestionVoById(String questionId);
    Question getQuestionById(String questionId);
    PageInfo<Question> list(PageInfo pageInfo);
    PageInfo<Question> listByUserId(int userId,PageInfo pageInfo);

    PageInfo<Question> listQuestionByAnswers(User user,PageInfo pageInfo);
}
