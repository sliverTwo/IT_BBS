package com.sliver.mapper;

import com.sliver.pojo.PostReplyVo;
import com.sliver.pojo.PostReplyVoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PostReplyVoMapper {
    int countByExample(PostReplyVoExample example);

    int deleteByExample(PostReplyVoExample example);

    int insert(PostReplyVo record);

    int insertSelective(PostReplyVo record);

    List<PostReplyVo> selectByExample(PostReplyVoExample example);

    int updateByExampleSelective(@Param("record") PostReplyVo record, @Param("example") PostReplyVoExample example);

    int updateByExample(@Param("record") PostReplyVo record, @Param("example") PostReplyVoExample example);
}