package com.sliver.controller.index;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;
import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.EncryptUtils;
import com.sliver.common.utils.NullUtils;
import com.sliver.pojo.ApplyBoarder;
import com.sliver.pojo.Board;
import com.sliver.pojo.ScoreLog;
import com.sliver.pojo.User;
import com.sliver.service.ApplyBoarderService;
import com.sliver.service.BoardService;
import com.sliver.service.ScoreLogService;
import com.sliver.service.UserService;

/**
 * 用户控制器
 * 
 * @author LIN
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private ScoreLogService scoreLogService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private ApplyBoarderService applyBoarderService;

	@RequestMapping("/index.do")
	public String toIndex() {
		return "user/index";
	}

	@RequestMapping("/admin.do")
	public String toAdmin() {
		return "admin/userManage";
	}

	/**
	 * 验证旧密码
	 * 
	 * @param session
	 * @param oldPassword
	 * @return
	 */
	@RequestMapping("/ackOldPassword.do")
	@ResponseBody
	public BBSResult ackOldPassword(HttpSession session, String oldPassword) {
		User logUser = (User) session.getAttribute("logUser");
		if (logUser.getPassword().equals(EncryptUtils.encryptPassword(oldPassword, logUser.getUsername()))) {
			return BBSResult.ok();
		}
		return BBSResult.build(555, "密码错误!");
	}

	/**
	 * 修改密码
	 * 
	 * @param session
	 * @param oldPassword
	 * @param newPassword
	 * @return
	 */
	@RequestMapping("/changePassword.do")
	@ResponseBody
	public BBSResult changePassword(HttpSession session, String oldPassword, String newPassword) {
		BBSResult bbsResult = ackOldPassword(session, oldPassword);
		User logUser = (User) session.getAttribute("logUser");
		if (!bbsResult.equals(BBSResult.ok())) {
			return bbsResult;
		}
		if (StringUtils.isEmpty(newPassword)) {
			return BBSResult.build(555, "新密码为空!");
		}
		logUser.setPassword(EncryptUtils.encryptPassword(newPassword, logUser.getUsername()));
		int i = userService.update(logUser);
		if (i <= 0) {
			return BBSResult.build(554, "密码更改失败，请稍后重试！");
		}
		session.setAttribute("logUser", logUser);
		return BBSResult.ok();
	}

	@RequestMapping(value = "/toListPage")
	public String toListPage(@RequestParam("url") String url) {
		System.out.println(url);
		if (org.springframework.util.StringUtils.isEmpty(url)) {
			return "user/index";
		}
		return "user/" + url;
	}

	@RequestMapping("/changeUserInfo")
	@ResponseBody
	public BBSResult changeUserInfo(HttpSession session, User user) {
		User logUser = (User) session.getAttribute("logUser");
		if (!logUser.getId().equals(user.getId())) {
			return BBSResult.build(555, "修改异常，请刷新页面重试!");
		}
		// 将不能修改的值清空
		int i = userService.updateBasicInfo(user);
		if (i < 1) {
			return BBSResult.build(555, "修改异常，请刷新页面重试!");
		}
		logUser = userService.getUserById(logUser.getId());
		logUser.setPassword(null);
		session.setAttribute("logUser", logUser);
		return BBSResult.ok();
	}

	@RequestMapping("/changeUserPic")
	@ResponseBody
	public BBSResult changeUserPic(HttpSession session, User user) {
		User logUser = (User) session.getAttribute("logUser");
		user.setPic(StringEscapeUtils.escapeJava(user.getPic()));
		if (NullUtils.isNull(user, user.getId(), user.getPic())) {
			return BBSResult.build(533, "请先登陆！");
		}
		BBSResult bbsResult = BBSResult.build(555, "头像上传失败，请刷新页面重试!");
		if (!logUser.getId().equals(user.getId())) {
			return bbsResult;
		}
		int i = userService.updateBasicInfo(user);
		if (i < 1) {
			return bbsResult;
		}
		logUser.setPic(user.getPic());
		session.setAttribute("logUser", logUser);
		return BBSResult.ok();
	}

	/**
	 * 积分日志
	 * 
	 * @param page
	 * @param limit
	 * @param session
	 * @return
	 */
	@RequestMapping("/listScoreLog.do")
	@ResponseBody
	public BBSListResult listScoreLog(Integer page, Integer limit, HttpSession session) {
		User user = (User) session.getAttribute("logUser");
		if (null == user) {
			return BBSListResult.build(555, "请登陆后查看！");
		}
		PageInfo<ScoreLog> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<ScoreLog> scoreLogPageInfo = scoreLogService.listLog(user, pageInfo);
		return BBSListResult.ok(scoreLogPageInfo.getTotal(), scoreLogPageInfo.getList());
	}

	@RequestMapping("/toBoardManage")
	public String toBoardManage(HttpSession session, HttpServletRequest request) {
		User user = (User) session.getAttribute("logUser");
		Board board = boardService.getBoardByUserId(user.getId());
		if (board == null) {
			return null;
		}
		request.setAttribute("board", board);
		return "user/boardManage/boardInfo";
	}

	/**
	 * 用户列表
	 * 
	 * @param page
	 * @param limit
	 * @param session
	 * @return
	 */
	@RequestMapping("/listUser.do")
	@ResponseBody
	public BBSListResult listUser(Integer page, Integer limit, HttpSession session) {
		User user = (User) session.getAttribute("logUser");
		if (null == user) {
			return BBSListResult.build(555, "请登陆后查看！");
		}
		if (user.getLevel() != 2) {
			return BBSListResult.build(555, "无权限");
		}
		PageInfo<User> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<User> users = userService.list(pageInfo);
		return BBSListResult.ok(users.getTotal(), users.getList());
	}

	/**
	 * 冻结用户
	 * 
	 * @param userId
	 * @param reason
	 * @return
	 */
	@RequestMapping("/freezeUser.do")
	@ResponseBody
	public BBSResult freezeUser(Integer userId, String reason) {
		if (null == userId) {
			return BBSResult.build(555, "冻结失败！");
		}
		int i = userService.delete(userId, reason);
		if (i < 1) {
			return BBSResult.build(555, "冻结失败！");
		}
		return BBSResult.ok();
	}

	/**
	 * 启用用户
	 * 
	 * @param userId
	 * @param reason
	 * @return
	 */
	@RequestMapping("/launchUser.do")
	@ResponseBody
	public BBSResult launchUser(Integer userId, String reason) {
		if (null == userId) {
			return BBSResult.build(555, "启用失败！");
		}
		int i = userService.launchUser(userId, reason);
		if (i < 1) {
			return BBSResult.build(555, "启用失败！");
		}
		return BBSResult.ok();
	}

	@RequestMapping("/toApplyBoarder.do")
	public String toApplyBoarder(HttpServletRequest request) {
		List<Board> boards = boardService.listBoardNotExistsBoarder();
		request.setAttribute("boardList", boards);
		return "user/boardManage/applyBoarder";
	}

	/**
	 * 申请版主
	 * 
	 * @param applyBoarder
	 * @param session
	 * @return
	 */
	@RequestMapping("/applyBoarder.do")
	@ResponseBody
	public BBSResult applyBoarder(ApplyBoarder applyBoarder, HttpSession session) {
		User logUser = (User) session.getAttribute("logUser");
		if (null == logUser) {
			return BBSResult.build(333, "你已离线，请登陆后再申请！");
		}
		if (null == applyBoarder) {
			return BBSResult.build(404, "申请失败，请稍后重试！");
		}
		if (NullUtils.isNull(applyBoarder.getApplyReason(), applyBoarder.getBoardId())) {
			return BBSResult.build(555, "请将申请信息填写完整！");
		}
		applyBoarder.setUserId(logUser.getId());
		applyBoarder.setUsername(logUser.getUsername());
		int i = applyBoarderService.insert(applyBoarder);
		if (i < 1) {
			return BBSResult.build(555, "未知的错误发生了，请稍后重试！");
		}
		return BBSResult.ok();
	}

}
