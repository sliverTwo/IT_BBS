package com.sliver.controller.index;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.pojo.PublicInfo;
import com.sliver.service.PublicInfoService;

@Controller
@RequestMapping("/publicInfo")
public class PublicInfoController {
//    @Autowired
	@Resource
	private PublicInfoService publicInfoService;

	private Logger logger = Logger.getLogger(PublicInfoController.class);

	@RequestMapping("/savePublicInfo.do")
	@ResponseBody
	public BBSResult savePublicInfo(PublicInfo publicInfo) {
		// 必填字段检测
		if (null == publicInfo.getContent() || null == publicInfo.getTitle()) {
			return BBSResult.build(554, "你有必填信息未填！请填好后重新发布！");
		}
		logger.info(publicInfo);
		publicInfoService.insert(publicInfo);
		return BBSResult.ok();
	}

	@RequestMapping("/toAddPublicInfo.do")
	public String toAddPublicInfo() {
		return "admin/newPublicInfo";
	}

	@RequestMapping("toListPublicInfoManageUI.do")
	public String toListPublicInfoManageUI() {
		return "admin/publicInfoManage";
	}

	@RequestMapping("/listPublicInfo.do")
	@ResponseBody
	public BBSListResult listPublicInfo(Integer page, Integer limit) {
		logger.info("currPage:" + page);
		logger.info("pageSize:" + limit);
		PageInfo<PublicInfo> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<PublicInfo> list = publicInfoService.list(pageInfo);
		logger.info(list);
		return BBSListResult.ok(list.getTotal(), list.getList());
	}

	@RequestMapping("/toPublicInfo.do")
	public String toPublicInfo(Integer publicInfoId, HttpServletRequest request) {
		if (null == publicInfoId) {
			return "common/index";
		}
		PageInfo<PublicInfo> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(6);
		pageInfo.setNextPage(1);
		PublicInfo publicInfo = publicInfoService.getPublicInfoById(publicInfoId);

		request.setAttribute("publicInfo", publicInfo);
		return "common/publicInfoDetail";
	}

	@RequestMapping("/toEditPublicInfo")
	public String toEditPublicInfo(Integer publicInfoId, HttpServletRequest request) {
		PublicInfo publicInfo = publicInfoService.getPublicInfoById(publicInfoId);
		request.setAttribute("publicInfo", publicInfo);
		return "admin/editPublicInfo";
	}

	@RequestMapping("/deletePublicInfo.do")
	@ResponseBody
	public BBSResult deletePublicInfo(Integer publicInfoId) {
		int i = publicInfoService.delete(publicInfoId);
		if (i > 0) {
			return BBSResult.ok();
		}
		return BBSResult.build(555, "删除失败，请刷新后页面重试");
	}

	@RequestMapping("/updatePublicInfo.do")
	@ResponseBody
	public BBSResult updatePublicInfo(HttpSession session, PublicInfo publicInfo) {
		// 必填字段检测
		if (null == publicInfo.getContent() || null == publicInfo.getTitle()) {
			return BBSResult.build(554, "你有必填信息未填！请填好后重新发布！");
		}
		logger.info(publicInfo);
		int i = publicInfoService.update(publicInfo);
		if (i > 0) {
			return BBSResult.ok();
		}
		return BBSResult.build(555, "修改失败，请刷新页面后重试！");
	}

}
