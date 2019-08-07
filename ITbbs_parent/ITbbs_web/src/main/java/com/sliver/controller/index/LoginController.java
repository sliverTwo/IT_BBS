package com.sliver.controller.index;

import com.alibaba.druid.util.StringUtils;
import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.NullUtils;
import com.sliver.pojo.User;
import com.sliver.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


/*
 * 登陆
 * 
 */
@Controller
@RequestMapping("/login")
public class LoginController
{

    Logger log = Logger.getLogger(LoginController.class);
	@Autowired
	UserService userService;


	@RequestMapping("/toLogin.do")
	public String toLogin(HttpSession session,String pathLocation,HttpServletRequest request)
	{
		// 清除session信息
		session.setAttribute("logUser", null);
		if(!com.sliver.common.utils.StringUtils.isEmpty(pathLocation)){
            request.setAttribute("pathLocation",pathLocation);
        }
		return "common/login";
	}

	// 登录
	@ResponseBody
	@RequestMapping("login.do")
	public BBSResult login(HttpServletRequest request, User user,String pathLocation,String yanzhengma) {
	    if(NullUtils.isNull(user,yanzhengma)){
	        return BBSResult.build(500,"参数为空");
        }
        log.info("user:"+user);
//        log.info("pathLocation:"+pathLocation);
        HttpSession session = request.getSession(true);
        String yanzhengmasession=(String)session.getAttribute("yanzhengma");
		String msg="";
		if(!yanzhengma.equalsIgnoreCase(yanzhengmasession)){
			msg="验证码错误！";
			return BBSResult.build(555, msg);
		}
		if(null == user.getUsername()){
			msg = "用户名不能为空！";
			return BBSResult.build(555, msg);
		}
		if(null == user.getPassword()){
			msg = "密码不能为空！";
			return BBSResult.build(555, msg);
		}
		User logUser = userService.login(user);
		if(null == logUser){
			msg = "用户名或密码错误！";
			return BBSResult.build(555, msg);
		}
		// 用户被管理员冻结
		if(logUser.getDeleted()){
			msg = "你的用户被管理员冻结，请联系管理员！";
			return BBSResult.build(555, msg);
		}
		logUser.setPassword(null);
		session.setAttribute("logUser", logUser);
		session.setAttribute("userAlterFlag",false);
		if(StringUtils.isEmpty(pathLocation)){
			 pathLocation = request.getContextPath()+"/user/index.do";
		}
		// 管理员
		if(logUser.getLevel().equals(Integer.valueOf(2))){
            pathLocation = request.getContextPath()+"/user/admin.do";
        }
		return BBSResult.ok(pathLocation);
	}

	@RequestMapping("logout.do")
	public String logOut(HttpSession session,HttpServletRequest request){
		//清除登陆信息
		session.setAttribute("logUser",null);
		// 跳转至登陆界面
		return toLogin(session,"",request);
	}
}
