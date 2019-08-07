package com.sliver.controller.index;

import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.StringUtils;
import com.sliver.pojo.Message;
import com.sliver.pojo.User;
import com.sliver.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/message")
public class MessageController {
    @Autowired
    private MessageService messageService;

    @RequestMapping("/listMessage.do")
    @ResponseBody
    public BBSListResult listMessage(Integer page, Integer limit, HttpSession session){
        User user = (User)session.getAttribute("logUser");
        if(null == user){
            return BBSListResult.build(555,"请登陆后查看！");
        }
        PageInfo<Message> pageInfo = new PageInfo<>();
        pageInfo.setPageSize(limit);
        pageInfo.setNextPage(page);
        PageInfo<Message> messages = messageService.list(pageInfo,user.getId());
        return BBSListResult.ok(messages.getTotal(),messages.getList());
    }

    @RequestMapping("/deleteMessage.do")
    @ResponseBody
    public BBSResult deleteMessage(String messageId){
        if(null == messageId){
            return BBSResult.build(404,"删除失败！");
        }
        messageService.deleteMessage(messageId);
        return BBSResult.ok();
    }

    @RequestMapping("/readMessage.do")
    @ResponseBody
    public BBSResult readMessage(String messageId){
        if (StringUtils.isEmpty(messageId)){
            return BBSResult.build(444,"数据接收失败！");
        }
        messageService.receiveMessage(messageId);
        return BBSResult.ok();
    }

    @RequestMapping("countNotReadMessage.do")
    @ResponseBody
    public BBSResult countNotReadMessage(HttpSession session){
        User user =(User)session.getAttribute("logUser");
        if(null == user){
            return BBSResult.build(404,"用户未登陆");
        }
        int i = messageService.countNotReadMessage(user.getId());
        return BBSResult.ok(i);
    }
}
