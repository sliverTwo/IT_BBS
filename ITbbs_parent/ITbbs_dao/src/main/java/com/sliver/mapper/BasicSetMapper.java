package com.sliver.mapper;

import com.sliver.pojo.BasicSet;
import com.sliver.pojo.BasicSetExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface BasicSetMapper {
    int countByExample(BasicSetExample example);

    int deleteByExample(BasicSetExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(BasicSet record);

    int insertSelective(BasicSet record);

    List<BasicSet> selectByExample(BasicSetExample example);

    BasicSet selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") BasicSet record, @Param("example") BasicSetExample example);

    int updateByExample(@Param("record") BasicSet record, @Param("example") BasicSetExample example);

    int updateByPrimaryKeySelective(BasicSet record);

    int updateByPrimaryKey(BasicSet record);
}