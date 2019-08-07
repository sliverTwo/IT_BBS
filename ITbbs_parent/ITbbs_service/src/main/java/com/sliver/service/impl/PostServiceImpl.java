package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.utils.IDUtils;
import com.sliver.common.utils.NullUtils;
import com.sliver.mapper.PostMapper;
import com.sliver.pojo.Board;
import com.sliver.pojo.Post;
import com.sliver.pojo.PostExample;
import com.sliver.pojo.User;
import com.sliver.service.*;
import com.sliver.service.Exception.NullFieldException;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * 帖子service
 * @author LIN
 */
@Service("postService")
public class PostServiceImpl  implements PostService{
    @Autowired
    private PostMapper postMapper;
    @Autowired
    private UserService userService;
    @Autowired
    private FavoriteService favoriteService;
    @Autowired
    private MessageService messageService;
    @Autowired
    private LogService logService;
    @Autowired
    private ScoreLogService scoreLogService;
    @Autowired
    private  BoardService boardService;
    @Override
    public int insert(Post post) throws Exception{
        // 必填字段检测
        if(null ==post.getBoardId()|| null == post.getContent()
            || null == post.getTitle() || null == post.getUserId()){
            throw new NullFieldException("必填字段为空！");
        }
        // 更改用户发帖数
        User user = userService.getUserById(post.getUserId());
        if(null == user){
            return  -1;
        }
        user.setPostNum(user.getPostNum() + 1);
        userService.update(user);
        post.setId(IDUtils.getUUID());
        post.setCreatetime(new Date());
        return  postMapper.insertSelective(post);
    }

    @Override
    public int update(Post post) {
        // 必填字段检测
        if(null == post.getBoardId()|| null == post.getContent()
                || null == post.getTitle() || null == post.getUserId()){
            return 0;
        }
        // 将不能更改的值设置为空
        post.setDeleted(null);
        post.setAltertime(new Date());
        return postMapper.updateByPrimaryKeySelective(post);
    }

    @Override
    public int delete(String postId) {
        Post post = postMapper.selectByPrimaryKey(postId);
        post.setDeleted(true);
        return postMapper.updateByPrimaryKeySelective(post);
    }

    @Override
    public int delete(Post post) {
        // 删除相关收藏
        favoriteService.deleteByPostId(post.getId());
        post.setAltertime(new Date());
        post.setDeleted(true);
        return postMapper.updateByPrimaryKeySelective(post);
    }

    @Override
    public int deleteByBoard(Integer boardId) {
        Post post = new Post();
        post.setDeleted(true);
        PostExample postExample = new PostExample();
        PostExample.Criteria criteria = postExample.createCriteria();
        criteria.andBoardIdEqualTo(boardId);
        return postMapper.updateByExampleSelective(post, postExample);

    }

    @Override
    public Post getPostById(String postId) {
        Post post = postMapper.selectByPrimaryKey(postId);
        if(post.getDeleted()){
            return null;
        }
        return post;
    }

    @Override
    public PageInfo list(PageInfo pageInfo) {
        PostExample example = new PostExample();
        PostExample.Criteria criteria = example.createCriteria();
        criteria.andDeletedEqualTo(false);
        String orderBy = "createtime desc";
        return listByExample(example,orderBy,pageInfo);
    }

    @Override
    public PageInfo listByUserId(int userId, PageInfo pageInfo) {
        PostExample example = new PostExample();
        PostExample.Criteria criteria = example.createCriteria();
        criteria.andDeletedEqualTo(false);
        criteria.andUserIdEqualTo(userId);
        String orderBy = "createtime desc";
        return listByExample(example,orderBy,pageInfo);
    }

    @Override
    public PageInfo<Post> listByBoardId(int boardId, PageInfo pageInfo) {
        PostExample example = new PostExample();
        PostExample.Criteria criteria = example.createCriteria();
        criteria.andDeletedEqualTo(false);
        criteria.andBoardIdEqualTo(boardId);
        String orderBy = "is_top desc,createtime desc";
        return listByExample(example,orderBy,pageInfo);
    }

    @Override
    public int countPostByBoardId(Integer boardId) {
        PostExample postExample = new PostExample();
        PostExample.Criteria criteria = postExample.createCriteria();
        criteria.andBoardIdEqualTo(boardId);
        return postMapper.countByExample(postExample);
    }

    /**
     * 增加浏览数
     * @param post
     */
    @Override
    public void addViewNum(Post post) {
        post = postMapper.selectByPrimaryKey(post.getId());
        if(null == post){
            return;
        }
        Integer viewNum = post.getViewNum()+1;
        if(viewNum % 300 == 0){
            // 奖励10积分
            User user = userService.getUserById(post.getUserId());
            if(null != user) {
                user.setScore(user.getScore() + 10);
                scoreLogService.insert("帖子"
                        +(post.getTitle().length()>10?post.getTitle().substring(0,10)+"...":post.getTitle())
                        +"浏览数达到"+post.getViewNum(), 10, user.getId());
                logService.insert("用户" +user.getUsername()+"发布的帖子"+post+"浏览数达到"+post.getViewNum()
                +",奖励积分10");
            }
        }
        post.setViewNum(viewNum);
        postMapper.updateByPrimaryKeySelective(post);
    }

    @Override
    public PageInfo<Post> listPostByKeyword(String keyword, PageInfo pageInfo) {
        keyword = StringEscapeUtils.escapeHtml4(keyword);
        keyword = "%" + keyword+"%";
        PostExample example = new PostExample();
        PostExample.Criteria criteria = example.createCriteria();
        criteria.andDeletedEqualTo(false);
        PostExample.Criteria orCriteria = example.or();
        criteria.andTitleLike(keyword);
        orCriteria.andContentLike(keyword);
        String orderBy = "is_top desc,view_num desc";
        return listByExample(example,orderBy,pageInfo);
    }

    @Override
    public int deleteByBoarder(String reason, String postId, Integer userId) {
        Post post = postMapper.selectByPrimaryKey(postId);
        User boarder = userService.getUserById(userId);
        if(NullUtils.isNull(post,boarder)){
            return  -1;
        }
        Board board = boardService.getBoardByUserId(boarder.getId());
        if(!board.getId().equals(post.getBoardId())){
            logService.insert("非"+board.getBoardName()+"版主"+boarder+"试图删除版块下帖子" + post);
            return -2;
        }
        User user = userService.getUserById(post.getUserId());
        StringBuilder content = new StringBuilder("版主删除了你的帖子:");
        content.append(post.getTitle());
        StringBuilder logContent = new StringBuilder("管理员删除" + user.getUsername());
        logContent.append("的帖子");
        logContent.append(post);
        StringBuilder commonContent = new StringBuilder();
        commonContent.append("\n原因为:");
        commonContent.append(reason);
        logContent.append(commonContent);
        content.append(commonContent);
        messageService.sendMessage("删除通知",content.toString(),post.getUserId());
        logService.insert(logContent.toString());
        post.setDeleted(true);
        return postMapper.updateByPrimaryKey(post);
    }

    @Override
    public int deleteByAdmin(String reason, String postId, Integer userId) {
        Post post = postMapper.selectByPrimaryKey(postId);
        if(null == post){
            return -2;
        }
        User user = userService.getUserById(post.getUserId());
        StringBuilder content = new StringBuilder("管理员删除了你的帖子:");
        content.append(post.getTitle());
        StringBuilder logContent = new StringBuilder("管理员删除" + user.getUsername());
        logContent.append("的帖子");
        logContent.append(post);
        StringBuilder commonContent = new StringBuilder();
        commonContent.append("\n原因为:");
        commonContent.append(reason);
        logContent.append(commonContent);
        content.append(commonContent);
        messageService.sendMessage("删除通知",content.toString(),post.getUserId());
        logService.insert(logContent.toString());
        post.setDeleted(true);
        return postMapper.updateByPrimaryKey(post);
    }

    /**
     * 置顶帖子
     * @param postId
     * @param userId
     * @return
     */
    @Override
    public int setTop(String postId, Integer userId) {
        User user = userService.getUserById(userId);
        Post post = postMapper.selectByPrimaryKey(postId);
        Board board = boardService.getBoardById(post.getBoardId());
        if(NullUtils.isNull(user,post,board)){
            return -1;
        }
        if(!board.getUserId().equals(user.getId()) && user.getLevel() != 2){
            return -2;
        }
        if(post.getIsTop()){
            post.setIsTop(false);
        }else{
            post.setIsTop(true);
        }
        return  postMapper.updateByPrimaryKeySelective(post);
    }


    private PageInfo<Post> listByExample(PostExample postExample,String orderBy, PageInfo<Post> pageInfo){
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 20;
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<Post> list =  postMapper.selectByExample(postExample);
        return new PageInfo<>(list);
    }
}
