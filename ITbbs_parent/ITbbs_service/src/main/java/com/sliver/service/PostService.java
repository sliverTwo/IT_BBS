package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.Post;

public interface PostService {
    int insert(Post post) throws Exception;
    int update(Post post);
    int delete(String postId);
    int delete(Post post);
    int deleteByBoard(Integer boardId);
    Post getPostById(String postId);
    PageInfo<Post> list(PageInfo<Post> pageInfo);
    PageInfo<Post> listByUserId(int userId,PageInfo<Post> pageInfo);
    PageInfo<Post> listByBoardId(int boardId,PageInfo<Post> pageInfo);
    int countPostByBoardId(Integer boardId);
    void addViewNum(Post post);

	PageInfo<Post> listPostByKeyword(String keyword, PageInfo<Post> pageInfo);

	int deleteByBoarder(String reason, String postId, Integer userId);
    int deleteByAdmin(String reason,String postId,Integer userId);
    int setTop(String postId,Integer userId);
}
