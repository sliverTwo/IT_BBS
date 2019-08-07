package com.sliver.service;

import java.util.List;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.User;

public interface UserService {
	PageInfo<User> list(PageInfo<User> pageInfo);

	PageInfo<User> list(PageInfo<User> pageInfo, String orderBy);

	void insert(User User);

	int delete(Integer id, String reason);

	int update(User user);

	int updateBasicInfo(User user);

	User getUserById(Integer id);

	int checkUsername(String username);

	int checkMail(String mail);

	User login(User user);

	List<User> listCandidateBoarder();

	void alterUserToBoarder(User user);

	void alterUserToBoarder(Integer userId);

	void alterBoardToUser(User user);

	void alterBoardToUser(Integer userId);

	int launchUser(Integer userId, String reason);

	User getAdmin();
}
