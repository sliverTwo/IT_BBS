package com.sliver.mapper;

import com.sliver.pojo.FavoriteVo;
import com.sliver.pojo.FavoriteVoExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FavoriteVoMapper {
    int countByExample(FavoriteVoExample example);

    int deleteByExample(FavoriteVoExample example);

    int insert(FavoriteVo record);

    int insertSelective(FavoriteVo record);

    List<FavoriteVo> selectByExample(FavoriteVoExample example);

    int updateByExampleSelective(@Param("record") FavoriteVo record, @Param("example") FavoriteVoExample example);

    int updateByExample(@Param("record") FavoriteVo record, @Param("example") FavoriteVoExample example);
}