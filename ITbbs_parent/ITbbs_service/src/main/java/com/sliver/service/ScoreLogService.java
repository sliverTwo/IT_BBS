package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.ScoreLog;
import com.sliver.pojo.User;

public interface ScoreLogService {
	void insert(String content, Integer score, Integer userId);

	PageInfo<ScoreLog> listLog(User user, PageInfo<ScoreLog> pageInfo);
}
