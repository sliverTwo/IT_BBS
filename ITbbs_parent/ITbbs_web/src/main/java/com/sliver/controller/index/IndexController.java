package com.sliver.controller.index;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sliver.pojo.BoardVo;
import com.sliver.pojo.PublicInfo;
import com.sliver.pojo.User;
import com.sliver.service.BoardService;
import com.sliver.service.PublicInfoService;
import com.sliver.service.UserService;

@Controller
public class IndexController {

	@Autowired
	private BoardService boardService;
	@Autowired
	private UserService userService;
	@Autowired
	private PublicInfoService publicInfoService;

	@RequestMapping("/index")
	public String toIndex(HttpServletRequest request) {
		List<BoardVo> boardVoList = boardService.list();
		List<PublicInfo> publicInfoList = publicInfoService.listForIndex();
		request.setAttribute("boardList", boardVoList);
		request.setAttribute("publicInfoList", publicInfoList);
		return "common/index";
	}

	@RequestMapping("/toPublicInfoList")
	public String toListPublicInfo() {
		return "common/publicInfoList";
	}

	@RequestMapping("/toBoardUI.do")
	public String toBoardUI(Integer boardId, HttpServletRequest request) {
		List<BoardVo> boardVoList = boardService.list();
		if (null == boardId) {
			boardId = boardVoList.get(0).getId();
			System.out.println(boardId);
		}
		request.setAttribute("boardList", boardVoList);
		request.setAttribute("boardId", boardId);
		return "common/viewBoard";
	}

	@RequestMapping("/toUserInfo.do")
	public String toUserInfo(Integer userId, HttpServletRequest request) {
		User user = userService.getUserById(userId);
		if (user == null) {
			request.setAttribute("err", "找不到此用户！");
			return "error";
		}
		request.setAttribute("userName", user.getUsername());
		if (user.getSecrecy()) {
			request.setAttribute("msg", "该用户未公开信息！");
		} else {
			request.setAttribute("user", user);
		}
		return "common/userInfo";
	}

	@RequestMapping("/toQuestionList")
	public String toQuestionList() {
		return "common/questionList";
	}

	@RequestMapping("/toFileList")
	public String toFileList() {
		return "common/fileList";
	}
}
