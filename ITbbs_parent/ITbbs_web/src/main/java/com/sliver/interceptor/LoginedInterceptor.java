package com.sliver.interceptor;

import com.sliver.common.utils.NullUtils;
import com.sliver.pojo.User;
import com.sliver.service.BoardService;
import com.sliver.service.UserService;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginedInterceptor implements HandlerInterceptor {
    // 拦截前处理
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Object logUser = session.getAttribute("logUser");
        if(null == logUser){
            response.sendRedirect(request.getContextPath() + "/login/toLogin.do");
            return false;
        }
        return true;
    }

    // 拦截后

    /**
     * 判断用户信息是否发生改变，若改变，刷新session中用户信息
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }

    // 全部完成后
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
