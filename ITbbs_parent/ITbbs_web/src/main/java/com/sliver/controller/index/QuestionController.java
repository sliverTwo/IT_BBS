package com.sliver.controller.index;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.pojo.AnswerVo;
import com.sliver.pojo.Question;
import com.sliver.pojo.QuestionVo;
import com.sliver.pojo.User;
import com.sliver.service.AnswerService;
import com.sliver.service.QuestionService;

/**
 * 问题控制器
 * 
 * @author LIN
 */
@Controller
@RequestMapping("/question")
public class QuestionController {

	@Autowired
	private QuestionService questionService;
	@Autowired
	private AnswerService answerService;

	@Value("${scoreLever}")
	private String scoreLever;

	private Logger logger = Logger.getLogger(QuestionController.class);

	/**
	 * 新建问题
	 * 
	 * @param session
	 * @param question
	 * @return
	 */
	@RequestMapping("/saveQuestion.do")
	@ResponseBody
	public BBSResult saveQuestion(HttpSession session, Question question) {
		// 必填字段检测
		if (null == question.getContent() || null == question.getTitle() || null == question.getPayScore()) {
			return BBSResult.build(554, "你有必填信息未填！请填好后重新发布！");
		}
		User logUser = (User) session.getAttribute("logUser");
		logger.info(question);
		if (null == logUser) {
			return BBSResult.build(555, "发布失败，请刷新页面后重试！");
		}
		logUser.setScore(logUser.getScore() - question.getPayScore());
		session.setAttribute("logUser", logUser);
		question.setUserId(logUser.getId());
		question.setUsername(logUser.getUsername());
		BBSResult bbsResult = questionService.insert(question);
		return bbsResult;
	}

	@RequestMapping("/toAddQuestion.do")
	public String toAddQuestion(HttpServletRequest request) {
		request.setAttribute("scoreLevers", scoreLever.split(","));
		return "user/answerQuestionManage/newQuestion";
	}

	/**
	 * 根据登陆用户列出用户的提问
	 * 
	 * @param page
	 * @param limit
	 * @param session
	 * @return
	 */
	@RequestMapping("/listMyQuestion.do")
	@ResponseBody
	public BBSListResult listMyQuestion(@RequestParam("page") Integer page, @RequestParam("limit") Integer limit,
			HttpSession session) {
		User user = (User) session.getAttribute("logUser");
		if (null == user) {
			return BBSListResult.build(555, "请刷新页面后重试！");
		}
		logger.info("currPage:" + page);
		logger.info("pageSize:" + limit);
		PageInfo<Question> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<Question> list = questionService.listByUserId(user.getId(), pageInfo);
		logger.info(list);
		return BBSListResult.ok(list.getTotal(), list.getList());
	}

	@RequestMapping("/listQuestion.do")
	@ResponseBody
	public BBSListResult listQuestion(@RequestParam("page") Integer page, @RequestParam("limit") Integer limit) {
		logger.info("currPage:" + page);
		logger.info("pageSize:" + limit);
		PageInfo<Question> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<Question> list = questionService.list(pageInfo);
		logger.info(list);
		return BBSListResult.ok(list.getTotal(), list.getList());
	}

	/**
	 * 列出登陆用户回答过的问题
	 * 
	 * @param page
	 * @param limit
	 * @param session
	 * @return
	 */
	@RequestMapping("/listQuestionByAnswers")
	@ResponseBody
	public BBSListResult listQuestionByAnswers(@RequestParam("page") Integer page, @RequestParam("limit") Integer limit,
			HttpSession session) {
		User logUser = (User) session.getAttribute("logUser");
		if (null == logUser) {
			return BBSListResult.build(555, "您未登陆，请登录后查看");
		}
		logger.info("currPage:" + page);
		logger.info("pageSize:" + limit);
		PageInfo<Question> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);

		PageInfo<Question> questionList = questionService.listQuestionByAnswers(logUser, pageInfo);
		return BBSListResult.ok(questionList.getTotal(), questionList.getList());
	}

	@RequestMapping("/toQuestionDetail.do")
	public String toQuestionDetail(String questionId, HttpServletRequest request) {
		QuestionVo question = questionService.getQuestionVoById(questionId);
		PageInfo<AnswerVo> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(6);
		pageInfo.setNextPage(1);
		PageInfo<AnswerVo> answerList = answerService.listAnswerByQuestionId(questionId, pageInfo);
		request.setAttribute("question", question);
		request.setAttribute("answerList", answerList.getList());
		request.setAttribute("answerCount", answerList.getTotal());
		return "common/questionDetail";
	}

	@RequestMapping("/deleteQuestion.do")
	@ResponseBody
	public BBSResult deleteQuestion(String questionId) {
		Question question = questionService.getQuestionById(questionId);
		if (null == question) {
			return BBSResult.build(555, "该问题不存在或已删除");
		}
		int i = questionService.delete(questionId);
		if (i == 0) {
			return BBSResult.build(555, "删除失败！该问题不存在或已删除");
		}
		return BBSResult.ok();
	}
}
