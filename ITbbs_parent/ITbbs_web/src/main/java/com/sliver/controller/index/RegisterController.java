package com.sliver.controller.index;

import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;
import com.sliver.common.constant.Constant;
import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.EncryptUtils;
import com.sliver.common.utils.MailUtils;
import com.sliver.common.utils.Tool;
import com.sliver.pojo.User;
import com.sliver.service.UserService;

/*
 * 注册
 * 
 */
@Controller
@RequestMapping("/register")
public class RegisterController {

	@Autowired
	private UserService userService;
	@Value("${defaultHeadPic}")
	private String defaultHeadPic;

	// 跳转注册页面
	@RequestMapping("/toRegister.do")
	public String toRegister(HttpServletRequest request) {
		request.getSession().removeAttribute("logUser");
		return "common/register";
	}

	// 新增
	@ResponseBody
	@RequestMapping("/register.do")
	public BBSResult add(HttpServletRequest request, User user, String code) {
		String msg = "";
		HttpSession session = request.getSession(true);
		String ackCode = (String) session.getAttribute("ackCode");
		if (!code.equalsIgnoreCase(ackCode)) {
			msg = "验证码错误！";
		} else if (user.getUsername().length() < 3) {
			msg = "用户名小于3位！";
		} else if (userService.checkUsername(user.getUsername()) == Constant.False) {
			msg = "该用户名已被使用！";
		} else if (userService.checkMail(user.getMail()) == Constant.False) {
			msg = "该邮箱已被注册！";
		} else if (user.getPassword().length() < 6) {
			msg = "密码小于6位！";
		} else {
			// 移除验证码
			session.removeAttribute("ackCode");
			// 加密密码
			user.setPassword(EncryptUtils.encryptPassword(user.getPassword(), user.getUsername()));
			user.setCreatetime(new Date());
			user.setAlterime(new Date());
			user.setDeleted(false);
			user.setScore(0);
			user.setPic(defaultHeadPic);
			userService.insert(user);
		}
		if ("".equals(msg)) {
			return BBSResult.ok();
		}
		return BBSResult.build(555, msg);
	}

	// 验证用户名
	@ResponseBody
	@RequestMapping("/checkUsername.do")
	public BBSResult checkUsername(String username) {
		int flag = userService.checkUsername(username);
		return BBSResult.build(flag, "");
	}

	// 验证邮箱
	@ResponseBody
	@RequestMapping("/checkMail.do")
	public BBSResult checkMail(String mail) {
		int flag = userService.checkMail(mail);
		return BBSResult.build(flag, "");
	}

	/**
	 *
	 * @param session
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sendAckCode.do")
	public BBSResult sendAckCode(HttpSession session, User user) {
		String email = user.getMail();
		String msg;
		String ackCode = Tool.getUUID().substring(0, 5);
		String subject = "用户激活";
		String sendMail = "您好，此次验证码是:" + ackCode + "，请及时激活。";
		session.removeAttribute("ackCode");
		try {
			MailUtils.sendMail(email, subject, sendMail);
			session.setAttribute("ackCode", ackCode);
		} catch (AddressException e) {
			msg = "邮件地址错误！";
			e.printStackTrace();
			return BBSResult.build(555, msg);
		} catch (MessagingException e) {
			msg = "发送邮件失败！";
			e.printStackTrace();
			return BBSResult.build(555, msg);
		}
		return BBSResult.ok();
	}

	@RequestMapping("/ackCode.do")
	@ResponseBody
	public BBSResult ackCode(HttpSession session, String ackCode) {
		String sessionAckCode = (String) session.getAttribute("ackCode");
		if (!StringUtils.isEmpty(sessionAckCode) && !StringUtils.isEmpty(ackCode)) {
			if (sessionAckCode.equals(ackCode)) {
				return BBSResult.ok();
			}
			return BBSResult.build(555, "验证码错误！");
		}
		return BBSResult.build(555, "验证码为空！");
	}
}
