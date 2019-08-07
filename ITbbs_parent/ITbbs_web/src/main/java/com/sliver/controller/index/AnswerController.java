package com.sliver.controller.index;

import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.pojo.Answer;
import com.sliver.pojo.AnswerVo;
import com.sliver.pojo.Question;
import com.sliver.pojo.User;
import com.sliver.service.AnswerService;
import com.sliver.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * 答案控制器
 * @author LIN
 */
@Controller
@RequestMapping("/answer")
public class AnswerController {
    @Autowired
    private AnswerService answerService;
    @Autowired
    private QuestionService questionService;

    @RequestMapping("/saveAnswer.do")
    @ResponseBody
    public BBSResult saveAnswer(Answer answer, HttpSession session){
        // 必填字段检测
        if(null == answer.getContent()){
            return BBSResult.build(554,"你有必填信息未填！请填好后重新发布！");
        }
        User logUser = (User)session.getAttribute("logUser");
        if(null == logUser){
            return BBSResult.build(555,"请登陆后在进行回复");
        }
        answer.setUserId(logUser.getId());
        int i = answerService.insert(answer);
        if(i <= 0 ){
            return BBSResult.build(555,"发布失败，请刷新页面后重试！");
        }
        return BBSResult.ok(new Date());
    }

    @RequestMapping("/ackAnswer.do")
    @ResponseBody
    public BBSResult ackAnswer(String answerId, String questionId){
        Question question = questionService.getQuestionById(questionId);
        Answer answer = answerService.getAnswerById(answerId);
        if(null == question || null == answer){
            return BBSResult.build(555,"确认失败，请刷新后重试！");
        }
        if(null != question.getUsefulAnswerId()){
            return BBSResult.build(554,"该问题已确认过回答！");
        }
        answerService.ackAnswer(answer,question);
        return BBSResult.ok();
    }

    @RequestMapping("/answerList.do")
    @ResponseBody
    public BBSListResult answerList(String questionId, Integer page){
        PageInfo<AnswerVo> pageInfo = new PageInfo<>();
        pageInfo.setPageSize(5);
        pageInfo.setNextPage(page);
        PageInfo<AnswerVo> replyList = answerService.listAnswerByQuestionId(questionId, pageInfo);
        return BBSListResult.ok((long) replyList.getPages(),replyList.getList());
    }
}
