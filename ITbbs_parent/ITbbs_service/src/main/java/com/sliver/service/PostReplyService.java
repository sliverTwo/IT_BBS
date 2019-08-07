package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.PostReply;
import com.sliver.pojo.PostReplyVo;

public interface PostReplyService {
    PageInfo<PostReplyVo> listPostReplyBypostId(String postId,PageInfo pageInfo);

    int insert(PostReply postReply);
    int deleteByAdmin(String reason,String postReplyId,Integer userId);
    int deleteByBoarder(String reason,String postReplyId,Integer userId);
}
