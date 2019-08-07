package com.sliver.controller.index;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.NullUtils;
import com.sliver.pojo.ApplyBoarder;
import com.sliver.pojo.User;
import com.sliver.service.ApplyBoarderService;
import com.sliver.service.BoardService;

/**
 * 后台管理
 * 
 * @author LIN
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private ApplyBoarderService applyBoarderService;
	@Autowired
	private BoardService boardService;

	@RequestMapping("/toApplyList.do")
	public String toApplyList() {
		return "admin/boarderApplyManage";
	}

	/**
	 * 有资格成为版主的用户
	 * 
	 * @param page
	 * @param limit
	 * @param session
	 * @return
	 */
	@RequestMapping("/listApplyBoarder.do")
	@ResponseBody
	public BBSListResult listApplyBoarder(Integer page, Integer limit, HttpSession session) {
		User user = (User) session.getAttribute("logUser");
		if (null == user) {
			return BBSListResult.build(555, "请登陆后查看！");
		}
		if (user.getLevel() != 2) {
			return BBSListResult.build(555, "无权限");
		}
		PageInfo<ApplyBoarder> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<ApplyBoarder> applyBorderPageInfo = applyBoarderService.list(pageInfo);
		return BBSListResult.ok(applyBorderPageInfo.getTotal(), applyBorderPageInfo.getList());
	}

	/**
	 * 检测版块名
	 * 
	 * @param boardId
	 * @return
	 */
	@RequestMapping("/checkBoardExistsBoarder.do")
	@ResponseBody
	public BBSResult checkBoardExistsBoarder(Integer boardId) {
		if (null == boardId) {
			return BBSResult.build(404, "请求错误，请稍候重试！");
		}
		int code = boardService.BoardExistsBoarder(boardId);
		if (code == -1) {
			return BBSResult.build(555, "找不到此板块，请刷新后重试！");
		}
		return BBSResult.build(code, "");
	}

	/**
	 * 处理版主申请
	 * 
	 * @param reason
	 * @param code
	 * @param applyBorder
	 * @return
	 */
	@RequestMapping("/dealApply.do")
	@ResponseBody
	public BBSResult dealApply(String reason, Integer code, ApplyBoarder applyBorder) {
		if (NullUtils.isNull(reason, code, applyBorder)) {
			return BBSResult.build(404, "处理失败，请稍后重试");
		}
		// 同意
		if (code == 1) {
			int i = applyBoarderService.approveApply(applyBorder, reason);
			if (i < 0) {
				return BBSResult.build(555, "处理失败，请稍后重试");
			}
		} else { // 拒绝
			int i = applyBoarderService.refuseApply(applyBorder, reason);
			if (i < 0) {
				return BBSResult.build(555, "处理失败，请稍后重试");
			}
		}
		return BBSResult.ok();
	}
}