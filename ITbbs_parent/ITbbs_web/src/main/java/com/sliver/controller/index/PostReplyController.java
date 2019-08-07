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
import com.sliver.common.utils.StringUtils;
import com.sliver.pojo.PostReply;
import com.sliver.pojo.PostReplyVo;
import com.sliver.pojo.User;
import com.sliver.service.PostReplyService;

@Controller
@RequestMapping("/postReply")
public class PostReplyController {
	@Autowired
	private PostReplyService postReplyService;

	@RequestMapping("/savePostReply.do")
	@ResponseBody
	public BBSResult savePostReply(HttpSession session, PostReply postReply) {
		// 必填字段检测
		if (null == postReply.getContent()) {
			return BBSResult.build(554, "你有必填信息未填！请填好后重新发布！");
		}
		User logUser = (User) session.getAttribute("logUser");
		if (null == logUser) {
			return BBSResult.build(555, "请登陆后在进行回复");
		}
		postReply.setUserId(logUser.getId());
		postReply.setUsername(logUser.getUsername());
		int i = postReplyService.insert(postReply);
		if (i <= 0) {
			return BBSResult.build(555, "发布失败，请刷新页面后重试！");
		}
		return BBSResult.ok();
	}

	@RequestMapping("/postReplyList.do")
	@ResponseBody
	public BBSListResult postReplyList(String postId, Integer page) {
		PageInfo<PostReplyVo> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(3);
		pageInfo.setNextPage(page);
		PageInfo<PostReplyVo> replyList = postReplyService.listPostReplyBypostId(postId, pageInfo);
		return BBSListResult.ok((long) replyList.getPages(), replyList.getList());
	}

	@RequestMapping("/deleteReply.do")
	@ResponseBody
	public BBSResult deleteReply(String reason, String postReplyId, HttpSession session) {
		if (NullUtils.isNull(reason, postReplyId) || StringUtils.isEmpty(reason, postReplyId)) {
			return BBSResult.build(404, "删除失败，请稍后重试！");
		}
		User logUser = (User) session.getAttribute("logUser");
		if (null == logUser || logUser.getLevel() == 0) {
			return BBSResult.build(500, "权限不足,不能删除！");
		}
		int i;
		if (logUser.getLevel() == 2) {
			i = postReplyService.deleteByAdmin(reason, postReplyId, logUser.getId());
		} else {
			i = postReplyService.deleteByBoarder(reason, postReplyId, logUser.getId());
		}
		if (i < 1) {
			return BBSResult.build(555, "修改失败！回复已删除或不存在！");
		}
		return BBSResult.ok();
	}

}
