package com.sliver.mapper;

import com.sliver.pojo.QuestionVo;
import com.sliver.pojo.QuestionVoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface QuestionVoMapper {
    int countByExample(QuestionVoExample example);

    int deleteByExample(QuestionVoExample example);

    int insert(QuestionVo record);

    int insertSelective(QuestionVo record);

    List<QuestionVo> selectByExample(QuestionVoExample example);

    int updateByExampleSelective(@Param("record") QuestionVo record, @Param("example") QuestionVoExample example);

    int updateByExample(@Param("record") QuestionVo record, @Param("example") QuestionVoExample example);
}