package com.sliver.mapper;

import com.sliver.pojo.ScoreLog;
import com.sliver.pojo.ScoreLogExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ScoreLogMapper {
    int countByExample(ScoreLogExample example);

    int deleteByExample(ScoreLogExample example);

    int deleteByPrimaryKey(String id);

    int insert(ScoreLog record);

    int insertSelective(ScoreLog record);

    List<ScoreLog> selectByExample(ScoreLogExample example);

    ScoreLog selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") ScoreLog record, @Param("example") ScoreLogExample example);

    int updateByExample(@Param("record") ScoreLog record, @Param("example") ScoreLogExample example);

    int updateByPrimaryKeySelective(ScoreLog record);

    int updateByPrimaryKey(ScoreLog record);
}