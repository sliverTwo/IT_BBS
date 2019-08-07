package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.File;

public interface FileService {
	int insert(File file);

	int delete(String fileId);

	PageInfo<File> listByUserId(Integer userId, PageInfo<File> pageInfo);

	File getFileById(String id);

	PageInfo<File> list(PageInfo<File> pageInfo);

	void downloadFile(Integer id, String id1);
}
