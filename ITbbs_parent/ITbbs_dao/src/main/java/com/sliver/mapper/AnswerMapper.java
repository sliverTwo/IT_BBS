package com.sliver.mapper;

import com.sliver.pojo.Answer;
import com.sliver.pojo.AnswerExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AnswerMapper {
    int countByExample(AnswerExample example);

    int deleteByExample(AnswerExample example);

    int deleteByPrimaryKey(String id);

    int insert(Answer record);

    int insertSelective(Answer record);

    List<Answer> selectByExample(AnswerExample example);

    Answer selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") Answer record, @Param("example") AnswerExample example);

    int updateByExample(@Param("record") Answer record, @Param("example") AnswerExample example);

    int updateByPrimaryKeySelective(Answer record);

    int updateByPrimaryKey(Answer record);
}