package com.sliver.mapper;

import com.sliver.pojo.ApplyBoarder;
import com.sliver.pojo.ApplyBoarderExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ApplyBoarderMapper {
    int countByExample(ApplyBoarderExample example);

    int deleteByExample(ApplyBoarderExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(ApplyBoarder record);

    int insertSelective(ApplyBoarder record);

    List<ApplyBoarder> selectByExample(ApplyBoarderExample example);

    ApplyBoarder selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") ApplyBoarder record, @Param("example") ApplyBoarderExample example);

    int updateByExample(@Param("record") ApplyBoarder record, @Param("example") ApplyBoarderExample example);

    int updateByPrimaryKeySelective(ApplyBoarder record);

    int updateByPrimaryKey(ApplyBoarder record);
}