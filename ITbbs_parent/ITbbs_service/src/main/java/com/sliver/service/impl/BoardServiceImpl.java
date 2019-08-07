package com.sliver.service.impl;

import com.sliver.common.constant.Constant;
import com.sliver.common.utils.DateUtils;
import com.sliver.common.utils.IDUtils;
import com.sliver.mapper.BoardMapper;
import com.sliver.mapper.ScoreLogMapper;
import com.sliver.pojo.*;
import com.sliver.service.BoardService;
import com.sliver.service.LogService;
import com.sliver.service.PostService;
import com.sliver.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 版块service
 * @author LIN
 */
@Service
public class BoardServiceImpl implements BoardService{
    org.apache.log4j.Logger logger = Logger.getLogger(BoardServiceImpl.class);
    @Autowired
    private BoardMapper boardMapper;

    @Autowired
    private LogService logService;

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;
    @Autowired
    private ScoreLogMapper scoreLogMapper;

    @Override
    public int insert(Board board) {
        Date now = new Date();
        board.setCreatetime(now);
        board.setAltertime(now);
        board.setOwnerTime(now);
        if(board.getUserId() != null){
            User user = userService.getUserById(board.getUserId());
            if(null == user){
                return 0;
            }
            userService.alterUserToBoarder(user);
            board.setUsername(user.getUsername());
            String logContent = user.getUsername() + "成为" + board.getBoardName() + "版主 userInfo" + user.toString();
            logService.insert(logContent);
        }else{
            board.setUserId(-1);
        }
        if(null == board.getOrderNum()){
            board.setOrderNum(0);
        }
        String content = "新增版块："+board.toString();
        logService.insert(content);
        return boardMapper.insertSelective(board);
    }
    @Override
    public int updateByAdmin(Board board) {
        Board b = boardMapper.selectByPrimaryKey(board.getId());
        if(null == b)
        {
            return -1;
        }
        // 版主更改
        if(board.getUserId() != b.getUserId()){
            User user = userService.getUserById(board.getUserId());
            if(null != user){
                logger.info("原版主Id:"+b.getUserId());
                logger.info("现版主Id:"+board.getUserId());
                board.setUsername(user.getUsername());

            }else{ // 版主置为空
                board.setUsername("");
                board.setScore(0);
                board.setUserId(-1);
            }
            this.alterBoarder(b.getUserId(),board.getUserId());
        }
        return boardMapper.updateByPrimaryKeySelective(board);
    }

    private void alterBoarder(Integer oldUserId, Integer userId) {
        if(oldUserId != null && oldUserId != -1){
            User oldUser = userService.getUserById(oldUserId);
            userService.alterBoardToUser(oldUser);
        }
        if(userId != null && userId !=-1){
            userService.alterUserToBoarder(userId);
        }
    }

    @Override
    public int updateByBorder(Board board){
        Board b = boardMapper.selectByPrimaryKey(board.getId());
        if(null == b)
        {
            return -1;
        }
        return boardMapper.updateByPrimaryKeySelective(board);
    }

    @Override
    public int delete(Integer boardId,String delReason) {
        Board board = boardMapper.selectByPrimaryKey(boardId);
        if(null == board){
            return 0;
        }
        // 取消版主
        userService.alterBoardToUser(board.getUserId());
        // 将版块内帖子标记为删除
        postService.deleteByBoard(boardId);
        // 记录日志
        String content = "删除了版块" + board.toString() + "原因为：" + delReason;
        logService.insert(content);
        return  boardMapper.deleteByPrimaryKey(boardId);
    }

    @Override
    public int checkBoardName(String boardName) {
        int flag = Constant.True;
        BoardExample example = new BoardExample();
        example.createCriteria().andBoardNameEqualTo(boardName);
        List<Board> list = boardMapper.selectByExample(example);
        if (list.size() > 0)
        {
            flag = Constant.False;
        }
        return flag;
    }


    @Override
    public Board getBoardById(Integer boardId) {
        return  boardMapper.selectByPrimaryKey(boardId);
    }

    @Override
    public List<BoardVo> list() {
        BoardExample example = new BoardExample();
        example.setOrderByClause("order_num desc");
        List<Board> boardList = boardMapper.selectByExample(example);
        List<BoardVo> boardVoList = new ArrayList<>();
        for (Board b:boardList) {
            BoardVo boardVo = new BoardVo();
            boardVo.setId(b.getId());
            boardVo.setBoardName(b.getBoardName());
            boardVo.setCreatetime(b.getCreatetime());
            boardVo.setUsername(b.getUsername());
            boardVo.setUserId(b.getUserId());
            boardVo.setIntroduce(b.getIntroduce());
            boardVo.setScore(b.getScore());
            boardVo.setPic(b.getPic());
            boardVo.setPostNum(postService.countPostByBoardId(b.getId()));
            boardVo.setOrderNum(b.getOrderNum());
            boardVoList.add(boardVo);
        }
        return boardVoList;
    }

    @Override
    public void dispenseScore() {
        BoardExample example = new BoardExample();
        example.setOrderByClause("order_num desc");
        List<Board> boardList = boardMapper.selectByExample(example);
        for (Board b:
             boardList) {
            Date ownerTime = b.getOwnerTime();
            Date now = new Date();
            try {
                int days = DateUtils.daysBetween(now, ownerTime);
                // 已有一个月，发放积分
                if(days%30 == 0){
                    Integer score = b.getScore();
                    User user = userService.getUserById(b.getUserId());
                    // 无版主
                    if(null == user){
                        continue;
                    }
                    user.setScore(user.getScore() + score);
                    userService.update(user);
                    // 记录日志
                    ScoreLog scoreLog = new ScoreLog();
                    scoreLog.setId(IDUtils.getUUID());
                    scoreLog.setCreatetime(now);
                    scoreLog.setContent("发放版主积分");
                    scoreLog.setScore(score);
                    scoreLogMapper.insert(scoreLog);
                }

            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

    }

    @Override
    public Board getBoardByUserId(Integer userId) {
        BoardExample example = new BoardExample();
        BoardExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdEqualTo(userId);
        List<Board> boards = boardMapper.selectByExample(example);
        if(null != boards && boards.size() > 0){
            return boards.get(0);
        }
        return null;
    }

    @Override
    public List<Board> listBoardNotExistsBoarder() {
        BoardExample example = new BoardExample();
        BoardExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdEqualTo(-1);
        return boardMapper.selectByExample(example);
    }

    @Override
    public int BoardExistsBoarder(Integer boarderId) {
        Board board = boardMapper.selectByPrimaryKey(boarderId);
        if(null == board){
            return -1;
        }
        if(board.getUserId() != null && board.getUserId() > 0){
            return 1;
        }
        return 0;
    }
}
