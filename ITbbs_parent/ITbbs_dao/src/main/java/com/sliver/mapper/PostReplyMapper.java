package com.sliver.mapper;

import com.sliver.pojo.PostReply;
import com.sliver.pojo.PostReplyExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PostReplyMapper {
    int countByExample(PostReplyExample example);

    int deleteByExample(PostReplyExample example);

    int deleteByPrimaryKey(String id);

    int insert(PostReply record);

    int insertSelective(PostReply record);

    List<PostReply> selectByExample(PostReplyExample example);

    PostReply selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") PostReply record, @Param("example") PostReplyExample example);

    int updateByExample(@Param("record") PostReply record, @Param("example") PostReplyExample example);

    int updateByPrimaryKeySelective(PostReply record);

    int updateByPrimaryKey(PostReply record);
}