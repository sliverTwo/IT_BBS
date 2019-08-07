package com.sliver.service;

import com.sliver.pojo.Board;
import com.sliver.pojo.BoardVo;

import java.util.List;

public interface BoardService {
    int insert(Board board);
    int updateByAdmin(Board board);
    int updateByBorder(Board board);
    int delete(Integer boardId,String delReason);
    // 版主名是否唯一
    int checkBoardName(String boardName);
    Board getBoardById(Integer boardId);
    List<BoardVo> list();
    // 发放版主积分
    void dispenseScore();
    Board getBoardByUserId(Integer userId);

    // 列出没有版主的版块
    List<Board> listBoardNotExistsBoarder();

    // 判断版块是否存在版主
    int BoardExistsBoarder(Integer boarderId);
}
