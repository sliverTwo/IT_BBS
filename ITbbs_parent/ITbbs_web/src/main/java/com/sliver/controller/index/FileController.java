package com.sliver.controller.index;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.pojo.User;
import com.sliver.service.FileService;
import com.sliver.service.UserService;

@Controller
@RequestMapping("/file")
public class FileController {

	@Value("${uploadFileDir}")
	private String uploadFileDir;
	@Value("${fileScoreLevel}")
	private String fileScoreLevel;
	@Autowired
	private FileService fileService;
	@Autowired
	private UserService userService;

	@RequestMapping("/checkDownloadQX")
	@ResponseBody
	public BBSResult checkDownloadQX(String fileId, HttpSession session) {
		System.out.println(fileId);
		User user = (User) session.getAttribute("logUser");
		if (null == user) {
			return BBSResult.build(533, "请先登陆！");
		}
		com.sliver.pojo.File fInfo = fileService.getFileById(fileId);
		user = userService.getUserById(user.getId());

		if (null == fInfo) {
			return BBSResult.build(404, "无此文件！");
		}
		if (fInfo.getUserId().equals(user.getId())) {
			return BBSResult.ok();
		}
		if (user.getScore().compareTo(fInfo.getScore()) < 0) {
			return BBSResult.build(555, "积分不足");
		}
		return BBSResult.ok();
	}

	@RequestMapping(value = "/download")
	public ResponseEntity<byte[]> download(HttpServletRequest request, HttpSession session,
			@RequestParam("fileId") String fileId) throws Exception {
		// 获取登陆用户
		User user = (User) session.getAttribute("logUser");
		if (null == user) {
			System.out.println("用户未登录！");
			return null;
		}
		// 获取文件信息
		com.sliver.pojo.File fileInfo = fileService.getFileById(fileId);
		if (null == fileInfo) {
			System.out.println("没有此文件！");
			return null;
		}
		if (user.getScore().compareTo(fileInfo.getScore()) < 0) {
			return null;
		}
		// 增加下载次数
//        fileService.addDownloadNum(fileInfo);
		// 扣除用户积分
		fileService.downloadFile(user.getId(), fileInfo.getId());

		// 下载文件路径
		String path = request.getSession().getServletContext().getRealPath("/") + fileInfo.getPath();
		File file = new File(path);
		HttpHeaders headers = new HttpHeaders();
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFielName = new String(fileInfo.getFilename().getBytes("UTF-8"), "iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFielName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}

	@RequestMapping("/toUploadFile")
	public String toUploadFile(HttpServletRequest request) {
		request.setAttribute("fileScoreLevel", fileScoreLevel.split(","));
		return "user/file/uploadFile";
	}

	@RequestMapping("/listUploadFileByUserId.do")
	@ResponseBody
	public BBSListResult uploadFileList(Integer page, Integer limit, HttpSession session) {
		User user = (User) session.getAttribute("logUser");
		if (null == user) {
			return BBSListResult.build(555, "请刷新页面后重试！");
		}
		PageInfo<com.sliver.pojo.File> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<com.sliver.pojo.File> list = fileService.listByUserId(user.getId(), pageInfo);
		return BBSListResult.ok(list.getTotal(), list.getList());
	}

	@RequestMapping("/listFile.do")
	@ResponseBody
	public BBSListResult listFile(Integer page, Integer limit) {
		PageInfo<com.sliver.pojo.File> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(limit);
		pageInfo.setNextPage(page);
		PageInfo<com.sliver.pojo.File> list = fileService.list(pageInfo);
		return BBSListResult.ok(list.getTotal(), list.getList());
	}

	@RequestMapping("/deleteFile.do")
	@ResponseBody
	public BBSResult deleteFile(String fileId, HttpSession session) {
		com.sliver.pojo.File file = fileService.getFileById(fileId);
		if (null == file) {
			return BBSResult.build(404, "删除失败！,文件不存在或已删除");
		}
		User user = (User) session.getAttribute("logUser");
		if (null == user) {
			return BBSResult.build(500, "请登陆后再试！");
		}
		if (!user.getId().equals(file.getUserId())) {
			return BBSResult.build(555, "没有删除权限！");
		}
		int i = fileService.delete(fileId);
		if (i < 1) {
			return BBSResult.build(404, "删除失败！,文件不存在或已删除");
		}
		return BBSResult.ok();
	}
}
