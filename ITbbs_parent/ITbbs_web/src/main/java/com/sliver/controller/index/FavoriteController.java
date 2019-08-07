package com.sliver.controller.index;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.sliver.common.pojo.BBSListResult;
import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.StringUtils;
import com.sliver.pojo.Favorite;
import com.sliver.pojo.FavoriteVo;
import com.sliver.pojo.User;
import com.sliver.service.FavoriteService;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {
	@Autowired
	private FavoriteService favoriteService;

	@RequestMapping("/addPost2Favorite")
	@ResponseBody
	public BBSResult addPost2Favorite(Favorite favorite) {
		System.out.println(favorite);
		Favorite f = favoriteService.getFavoriteByuIdAndPId(favorite.getUserId(), favorite.getPostId());
		if (null != f) {
			return BBSResult.build(555, "此帖子已收藏！");
		}
		int i = favoriteService.insert(favorite);
		if (i <= 0) {
			return BBSResult.build(555, "收藏失败！");
		}
		return BBSResult.ok();
	}

	@RequestMapping("/removePostFromFavorite")
	@ResponseBody
	public BBSResult removePostFromFavorite(Favorite favorite) {
		if (StringUtils.isEmpty(favorite.getId())) {
			return BBSResult.build(101, "该帖子不存在！");
		}
		int i = favoriteService.delete(favorite);
		if (i > 0) {
			return BBSResult.ok();
		}
		return BBSResult.build(555, "该帖子已被移出收藏夹！");
	}

	@RequestMapping("/listFavorite")
	@ResponseBody
	public BBSListResult listFavorite(@RequestParam("page") Integer currPage, @RequestParam("limit") Integer pageSize,
			HttpSession session) {
		User logUser = (User) session.getAttribute("logUser");
		if (null == logUser) {
			return BBSListResult.build(555, "请先登陆！");
		}
		PageInfo<FavoriteVo> pageInfo = new PageInfo<>();
		pageInfo.setPageSize(pageSize == null ? 1 : pageSize);
		pageInfo.setNextPage(currPage == null ? 10 : currPage);
		PageInfo<FavoriteVo> list = favoriteService.listFavoriteByUserId(logUser.getId(), pageInfo);
		return BBSListResult.ok(list.getTotal(), list.getList());
	}
}
