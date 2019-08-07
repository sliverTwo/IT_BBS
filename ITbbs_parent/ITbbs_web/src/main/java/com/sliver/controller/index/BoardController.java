package com.sliver.controller.index;

import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.pojo.Board;
import com.sliver.pojo.BoardVo;
import com.sliver.pojo.User;
import com.sliver.service.BoardService;
import com.sliver.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 版块控制器
 * @author LIN
 */
@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private UserService userService;

    // 月供积分数
    @Value("${scoreList}")
    public String socreList;

    @Value("${boardDefaultPic}")
    private  String boardDefaultPic;

    @RequestMapping("/toNewBoardUI.do")
    public String  toNewBoardUI(HttpServletRequest request){
        getBasicSet(request);
        return "admin/newBoard";
    }

    private void getBasicSet(HttpServletRequest request) {
        // 获取有版主资格的用户
        List<User> userList = userService.listCandidateBoarder();
        request.setAttribute("candidateList",userList);
        request.setAttribute("boardDefaultPic",boardDefaultPic);
        request.setAttribute("scoreList",socreList.split(","));
    }

    @ResponseBody
    @RequestMapping("/getCandidateBoarder.do")
    public BBSResult getCandidateBoarder(){
        List<User> userList = userService.listCandidateBoarder();
        return BBSResult.build(0,"",userList);
    }
    @RequestMapping("/toBoardListUI.do")
    public String  toBoardListUI(HttpServletRequest request){
        // 获取有版主资格的用户
        getBasicSet(request);
        return "admin/boardManage";
    }

    @RequestMapping("/saveBoard.do")
    @ResponseBody
    public BBSResult saveBoard(Board board){
        int i = boardService.insert(board);
        if(i > 0 ){
            return BBSResult.ok();
        }
        return  BBSResult.build(555,"新增版块失败，请稍后重试！");
    }

    @RequestMapping("/listBoard.do")
    @ResponseBody
    public BBSListResult listBoard(){
        List<BoardVo> boardList = boardService.list();
        return BBSListResult.ok((long) boardList.size(),boardList);
    }

    @ResponseBody
    @RequestMapping("/checkBoardName.do")
    public BBSResult checkBoardName(String boardName) {
        if(boardName == null){
            return BBSResult.build(555,"版块名不能为空！");
        }
        int flag = boardService.checkBoardName(boardName);
        return BBSResult.build(flag, "");
    }

    /**
     * 管理员修改版块
     * @param board
     * @return
     */
    @RequestMapping("/alterBoard.do")
    @ResponseBody
    public BBSResult alterBoard(Board board){
        System.out.println(board);
        int i = boardService.updateByAdmin(board);
        if(i <= 0){
            return BBSResult.build(555,"修改失败，请稍后重试");
        }
        return  BBSResult.ok();
    }

    /**
     * 版主修改版块
     * @param board
     * @return
     */
    @RequestMapping("/alterBoardByBorder.do")
    @ResponseBody
    public BBSResult alterBoardByBorder(Board board){
        int i = boardService.updateByBorder(board);
        if(i <= 0){
            return BBSResult.build(555,"修改失败，请稍后重试");
        }
        return  BBSResult.ok();
    }

    /**
     * 删除版块
     * @param board
     * @param delReason
     * @return
     */
    @ResponseBody
    @RequestMapping("/delBoard.do")
    public BBSResult delBoard(Board board,String delReason){
        if(board.getId() == null){
            return BBSResult.build(555,"参数错误！");
        }
        int i = boardService.delete(board.getId(),delReason);
        if(i == 0){
            return BBSResult.build(554,"删除失败！");
        }
        return BBSResult.ok();
    }
}


