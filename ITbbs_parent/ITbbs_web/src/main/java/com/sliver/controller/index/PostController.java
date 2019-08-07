package com.sliver.controller.index;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.StringUtils;
import com.sliver.pojo.Board;
import com.sliver.pojo.BoardVo;
import com.sliver.pojo.Post;
import com.sliver.pojo.User;
import com.sliver.service.BoardService;
import com.sliver.service.PostService;
import com.sliver.service.UserService;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	private PostService postService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private UserService userService;

	private Logger logger = Logger.getLogger(PostController.class);

	/**
	 * 保存帖子
	 * 
	 * @param session 用户session'
	 * @param post    帖子
	 * @return BBSResult
	 */
	@RequestMapping("/savePost.do")
	@ResponseBody
	public BBSResult savePost(HttpSession session, Post post) {
		// 必填字段检测
		if (null == post.getContent() || null == post.getTitle() || null == post.getBoardId()) {
			return BBSResult.build(554, "你有必填信息未填！请填好后重新发布！");
		}
		User logUser = (User) session.getAttribute("logUser");
		logger.info(post);
		Board board = boardService.getBoardById(post.getBoardId());
		if (null == board || null == logUser) {
			return BBSResult.build(555, "发布失败，请刷新页面后重试！");
		}
		ServletContext servletContext = session.getServletContext();
		String filterString = (String) servletContext.getAttribute("filterString");
		post.setContent(StringUtils.filterString(post.getContent(), filterString));
		post.setTitle(StringUtils.filterString(post.getTitle(), filterString));
		post.setBoardName(board.getBoardName());
		post.setBoardId(board.getId());
		post.setUserId(logUser.getId());
		post.setUserName(logUser.getUsername());
		try {
			postService.insert(post);
		} catch (Exception e) {
			logger.warn("帖子发布失败，失败信息：" + e.getMessage());
			logger.warn("帖子信息" + post.toString());
			return BBSResult.build(555, "发布失败，请刷新页面后重试！");
		}
		return BBSResult.ok();
	}

	/**
	 * 转到新建帖子页
	 * 
	 * @param request HttpServletRequest
	 * @return 新建帖子页
	 */
	@RequestMapping("/toAddPost.do")
	public String toAddPost(HttpServletRequest request) {
		List<BoardVo> boardList = boardService.list();
		request.setAttribute("boardList", boardList);
		return "user/postManage/newPost";
	}

	@RequestMapping("/listPost.do")
	@ResponseBody
	public BBSListResult listPost(Integer page, Integer limit, HttpSession session) {
		User user = (User) session.getAttribute("logUser");
		if (null == user) {
			return BBSListResult.build(555, "请刷新页面后重试！");
		}
		logger.info("currPage:" + page);
		logger.info("pageSize:" + limit);
		PageInfo<Post> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<Post> list = postService.listByUserId(user.getId(), pageInfo);
		logger.info(list);
		return BBSListResult.ok(list.getTotal(), list.getList());
	}

	@RequestMapping("/listPostByBoardId.do")
	@ResponseBody
	public BBSListResult listPostByBoardId(Integer page, Integer limit, Integer boardId) {
		logger.info("currPage:" + page);
		logger.info("pageSize:" + limit);
		PageInfo<Post> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<Post> list = postService.listByBoardId(boardId, pageInfo);
		logger.info(list);
		return BBSListResult.ok(list.getTotal(), list.getList());
	}

	@RequestMapping("/toPost.do")
	public String toPost(String postId, HttpServletRequest request) {
		if (null == postId) {
			return "common/index";
		}
		Post post = postService.getPostById(postId);
		if (null == post) {
			request.getRequestDispatcher("/index/toBoardUI.do");
		}
		Board board = boardService.getBoardById(post.getBoardId());
		postService.addViewNum(post);
		User user = userService.getUserById(post.getUserId());
		request.setAttribute("pUser", user);
		request.setAttribute("post", post);
		request.setAttribute("board", board);

		return "common/postDetail";
	}

	@RequestMapping("/toEditPost")
	public String toEditPost(String postId, HttpServletRequest request) {
		Post post = postService.getPostById(postId);
		List<BoardVo> boardList = boardService.list();
		request.setAttribute("boardList", boardList);
		request.setAttribute("post", post);
		return "user/postManage/editPost";
	}

	@RequestMapping("/deletePost.do")
	@ResponseBody
	public BBSResult deletePost(String postId) {
		int i = postService.delete(postId);
		if (i > 0) {
			return BBSResult.ok();
		}
		return BBSResult.build(555, "删除失败，请刷新后页面重试");
	}

	@RequestMapping("/updatePost.do")
	@ResponseBody
	public BBSResult updatePost(HttpSession session, Post post) {
		// 必填字段检测
		if (null == post.getContent() || null == post.getTitle() || null == post.getBoardId()) {
			return BBSResult.build(554, "你有必填信息未填！请填好后重新发布！");
		}
		User logUser = (User) session.getAttribute("logUser");
		logger.info(post);
		Board board = boardService.getBoardById(post.getBoardId());
		if (null == board || null == logUser) {
			return BBSResult.build(555, "修改失败，请刷新页面后重试！");
		}
		post.setBoardName(board.getBoardName());
		post.setBoardId(board.getId());
		post.setUserId(logUser.getId());
		post.setUserName(logUser.getUsername());
		int i = postService.update(post);
		if (i > 0) {
			return BBSResult.ok();
		}
		return BBSResult.build(555, "修改失败，请刷新页面后重试！");
	}

	@RequestMapping("/toSearchList")
	public String toSearchList(String keyword, HttpServletRequest request) {
		logger.info("keyword:" + keyword);
		request.setAttribute("keyword", keyword);
		return "common/searchPostList";
	}

	@RequestMapping("/listPostByKeyword.do")
	@ResponseBody
	public BBSListResult listPostByKeyword(Integer page, Integer limit, String keyword)
			throws UnsupportedEncodingException {
		if (StringUtils.isEmpty(keyword)) {
			return BBSListResult.build(555, "关键字不能为空！");
		}
		keyword = StringUtils.convertISO2utf8(keyword);
		logger.info("currPage:" + page);
		logger.info("pageSize:" + limit);
		logger.info("keyword:" + keyword);
		PageInfo<Post> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit == null ? 1 : limit);
		pageInfo.setNextPage(page == null ? 10 : page);
		PageInfo<Post> list = postService.listPostByKeyword(keyword, pageInfo);
		logger.info(list);
		return BBSListResult.ok(list.getTotal(), list.getList());
	}

	@RequestMapping("/dealTop.do")
	@ResponseBody
	public BBSResult dealTop(String postId, HttpSession session) {
		User logUser = (User) session.getAttribute("logUser");
		if (null == logUser || logUser.getLevel() == 0) {
			return BBSResult.build(404, "你没有权限进行操作");
		}
		int i = postService.setTop(postId, logUser.getId());
		if (i <= 0) {
			return BBSResult.build(555, "置顶失败");
		}
		return BBSResult.ok();
	}

	@RequestMapping("/deleteByPostOther.do")
	@ResponseBody
	public BBSResult deleteByPostOther(HttpSession session, String postId, String reason) {
		User logUser = (User) session.getAttribute("logUser");
		if (null == logUser || logUser.getLevel() == 0) {
			return BBSResult.build(404, "你没有权限进行操作");
		}
		int i;
		if (logUser.getLevel() == 2) {
			i = postService.deleteByAdmin(reason, postId, logUser.getId());
		} else {
			i = postService.deleteByBoarder(reason, postId, logUser.getId());
		}
		if (i < 1) {
			return BBSResult.build(555, "删除失败");
		}
		return BBSResult.ok();
	}
}
