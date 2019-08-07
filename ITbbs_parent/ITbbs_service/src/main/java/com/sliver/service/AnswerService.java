package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.*;

public interface AnswerService {
	PageInfo<AnswerVo> listAnswerByQuestionId(String questionId, PageInfo<AnswerVo> pageInfo);

	int insert(Answer answer);

	Answer getAnswerById(String answerId);

	void ackAnswer(Answer answer, Question question);
}
