package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.utils.NullUtils;
import com.sliver.mapper.ApplyBoarderMapper;
import com.sliver.pojo.ApplyBoarder;
import com.sliver.pojo.ApplyBoarderExample;
import com.sliver.pojo.Board;
import com.sliver.pojo.User;
import com.sliver.service.ApplyBoarderService;
import com.sliver.service.BoardService;
import com.sliver.service.MessageService;
import com.sliver.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ApplyBoarderServiceImpl implements ApplyBoarderService{
    @Autowired
    private ApplyBoarderMapper applyBorderMapper;
    @Autowired
    private UserService userService;
    @Autowired
    private BoardService boardService;
    @Autowired
    private MessageService messageService;

    @Override
    public int insert(ApplyBoarder applyBorder) {
        if (NullUtils.isNull(applyBorder.getUserId(),applyBorder.getBoardId(),applyBorder.getApplyReason())){
            return -1;
        }
        User user = userService.getUserById(applyBorder.getUserId());
        if(null == user){
            return  -2;
        }
        applyBorder.setUsername(user.getUsername());
        Board board = boardService.getBoardById(applyBorder.getBoardId());
        if(null == board){
            return -2;
        }
        applyBorder.setBoardName(board.getBoardName());
        applyBorder.setCreatetime(new Date());
        return applyBorderMapper.insertSelective(applyBorder);
    }

    @Override
    public int approveApply(ApplyBoarder applyBorder, String reason) {
        applyBorder = applyBorderMapper.selectByPrimaryKey(applyBorder.getId());
        // 设置申请人为版主
        userService.alterUserToBoarder(applyBorder.getUserId());
        Board board = boardService.getBoardById(applyBorder.getBoardId());
        if(null == board){
            return -2;
        }
        board.setUserId(applyBorder.getUserId());
        board.setUsername(applyBorder.getUsername());
        boardService.updateByAdmin(board);
        // 发送消息
        messageService.sendMessage("恭喜你，管理员同意了你的申请",applyBorder.getUserId());
        applyBorder.setDeal(true);
        return this.dealApply(applyBorder);
    }

    @Override
    public int refuseApply(ApplyBoarder applyBorder, String reason) {
        applyBorder = applyBorderMapper.selectByPrimaryKey(applyBorder.getId());
        // 发送消息
        messageService.sendMessage("管理员绝了你的申请,原因是"+reason,applyBorder.getUserId());
        applyBorder.setDeal(false);
        return this.dealApply(applyBorder);
    }

    @Override
    public PageInfo<ApplyBoarder> list(PageInfo pageInfo) {
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 20;
        ApplyBoarderExample applyBorderExample = new ApplyBoarderExample();
        ApplyBoarderExample.Criteria criteria = applyBorderExample.createCriteria();
        criteria.andDealIsNull();
        String orderBy = "createtime desc";
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<ApplyBoarder> applyBorders = applyBorderMapper.selectByExample(applyBorderExample);
        return new PageInfo<>(applyBorders);
    }

    private int dealApply(ApplyBoarder applyBorder){
        if(null == applyBorder.getId()){
            return -1;
        }
        ApplyBoarder apply = applyBorderMapper.selectByPrimaryKey(applyBorder.getId());
        if(null == apply){
            return -2;
        }
        apply.setDeal(applyBorder.getDeal());
        apply.setDealTime(new Date());
        return applyBorderMapper.updateByPrimaryKeySelective(apply);
    }
}
