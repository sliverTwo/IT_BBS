package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.PublicInfo;

import java.util.List;

public interface PublicInfoService {
	PageInfo<PublicInfo> list(PageInfo<PublicInfo> pageInfo);

	PublicInfo getPublicInfoById(Integer id);

	int insert(PublicInfo publicInfo);

	int delete(Integer publicInfoId);

	int update(PublicInfo publicInfo);

	List<PublicInfo> listForIndex();
}
