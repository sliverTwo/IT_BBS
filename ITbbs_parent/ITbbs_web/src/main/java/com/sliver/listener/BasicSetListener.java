package com.sliver.listener;


import com.sliver.service.BasicSetService;
import org.apache.log4j.Logger;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class BasicSetListener implements ServletContextListener {
    private  Logger logger  = Logger.getLogger(BasicSetListener.class);
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        BasicSetService basicSetService = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext()).getBean(BasicSetService.class);
        ServletContext servletContext = sce.getServletContext();
        logger.info("管理员邮箱:" + basicSetService.getMail());
        logger.info("敏感字符：" + basicSetService.getFilterString());
        servletContext.setAttribute("adminMail",basicSetService.getMail());
        servletContext.setAttribute("filterString",basicSetService.getFilterString());

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        BasicSetService basicSetService = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext()).getBean(BasicSetService.class);
        ServletContext servletContext = sce.getServletContext();
        String adminMail = (String)servletContext.getAttribute("adminMail");
        String filterString = (String)servletContext.getAttribute("filterString");
        basicSetService.setMail(adminMail);
        basicSetService.setFilterString(filterString);
    }
}
