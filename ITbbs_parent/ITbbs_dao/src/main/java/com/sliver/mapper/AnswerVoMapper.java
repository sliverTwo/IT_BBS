package com.sliver.mapper;

import com.sliver.pojo.AnswerVo;
import com.sliver.pojo.AnswerVoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AnswerVoMapper {
    int countByExample(AnswerVoExample example);

    int deleteByExample(AnswerVoExample example);

    int insert(AnswerVo record);

    int insertSelective(AnswerVo record);

    List<AnswerVo> selectByExample(AnswerVoExample example);

    int updateByExampleSelective(@Param("record") AnswerVo record, @Param("example") AnswerVoExample example);

    int updateByExample(@Param("record") AnswerVo record, @Param("example") AnswerVoExample example);
}