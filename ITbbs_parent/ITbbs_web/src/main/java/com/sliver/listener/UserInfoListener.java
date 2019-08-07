package com.sliver.listener;

import com.sliver.common.utils.NullUtils;
import com.sliver.pojo.User;
import com.sliver.service.BoardService;
import com.sliver.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.Timer;
import java.util.TimerTask;

public class UserInfoListener implements HttpSessionListener{
    private Timer timer = null;
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        // 初始化Timer
        timer = new Timer(true);
        session.getServletContext().log("用户信息刷新定时器已启动");
        timer.schedule(new UserInfoTimer(session),0,30*1000);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        timer.cancel();
        se.getSession().getServletContext().log("用户信息刷新定时器销毁");
    }
    class UserInfoTimer extends TimerTask {
        private HttpSession session;
        public UserInfoTimer(HttpSession session){
            this.session = session;
        }

        @Override
        public void run(){
            User logUser = (User)session.getAttribute("logUser");
            if(!NullUtils.isNull(logUser)){
                UserService userService = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext())
                        .getBean(UserService.class);
                logUser = userService.getUserById(logUser.getId());
                logUser.setPassword(null);
                session.setAttribute("logUser",logUser);
                session.getServletContext().log("用户信息刷新");
            }
        }
    }
}
