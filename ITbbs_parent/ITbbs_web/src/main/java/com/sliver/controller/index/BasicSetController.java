package com.sliver.controller.index;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.StringUtils;
import com.sliver.service.BasicSetService;

@RequestMapping("/basicSet")
@Controller
public class BasicSetController {
	@Autowired
	private BasicSetService basicSetService;

	@Autowired
	private ServletContext servletContext;

	@RequestMapping("/toBasicSetUI")
	public String toBaiscSetUI() {
		return "admin/basicManage";
	}

	@RequestMapping("/alterAdminMail")
	@ResponseBody
	public BBSResult alterAdminMail(String adminMail) {
		if (StringUtils.isEmpty(adminMail)) {
			return BBSResult.build(404, "修改失败，请稍后重试！");
		}
		basicSetService.setMail(adminMail);
		servletContext.setAttribute("adminMail", adminMail);
		return BBSResult.ok();
	}

	@RequestMapping("/alterFilterString")
	@ResponseBody
	public BBSResult alterFilterString(String filterString) {
		if (StringUtils.isEmpty(filterString)) {
			return BBSResult.build(404, "修改失败，请稍后重试！");
		}
		basicSetService.setFilterString(filterString);
		servletContext.setAttribute("filterString", filterString);
		return BBSResult.ok();
	}
}
