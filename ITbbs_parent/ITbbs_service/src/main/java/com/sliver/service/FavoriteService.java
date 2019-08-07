package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.Favorite;
import com.sliver.pojo.FavoriteVo;

public interface FavoriteService {
	int insert(Favorite favorite);

	int delete(Favorite favorite);

	int delete(String postId);

	PageInfo<FavoriteVo> listFavoriteByUserId(Integer userId, PageInfo<FavoriteVo> pageInfo);

	Favorite getFavoriteById(String favoriteId);

	Favorite getFavoriteByuIdAndPId(Integer userId, String PostId);

	int deleteByPostId(String postId);
}
