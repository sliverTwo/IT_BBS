package com.sliver.listener;

import com.sliver.service.BoardService;
import org.apache.log4j.Logger;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Timer;
import java.util.TimerTask;

public class TimeScheduleistener implements ServletContextListener{
    private Timer timer = null;
    private Logger logger = Logger.getLogger(this.getClass());
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 初始化Timer
        timer = new Timer(true);
        sce.getServletContext().log("积分发放定时器已启动");
        timer.schedule(new DispenseScore(sce.getServletContext()),0,24*60*60*1000);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        timer.cancel();
        sce.getServletContext().log("积分发放定时器销毁");
    }
    class DispenseScore extends TimerTask{
        private ServletContext servletContext;
        public DispenseScore(ServletContext servletContext){
            this.servletContext = servletContext;
        }

        @Override
        public void run(){
            BoardService boardService = WebApplicationContextUtils.getWebApplicationContext(servletContext).getBean
                    (BoardService
                    .class);
            // 发放积分
            logger.info("发放积分");
            boardService.dispenseScore();
        }
    }
}
