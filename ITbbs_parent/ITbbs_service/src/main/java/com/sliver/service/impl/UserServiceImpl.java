package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.constant.Constant;
import com.sliver.common.utils.EncryptUtils;
import com.sliver.common.utils.MailUtils;
import com.sliver.mapper.UserMapper;
import com.sliver.pojo.User;
import com.sliver.pojo.UserExample;
import com.sliver.service.BasicSetService;
import com.sliver.service.LogService;
import com.sliver.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.mail.MessagingException;
import java.util.Date;
import java.util.List;

/**
 * 用户service
 * @author LIN
 */
@Service("userService")
public class UserServiceImpl implements UserService
{
	@Autowired
	private  UserMapper userMapper;

 	@Autowired
    private LogService logService;
    @Autowired
    private BasicSetService basicSetService;


	public PageInfo list(PageInfo pageInfo)
	{
        return  list(pageInfo,null);
	}

    @Override
    public PageInfo list(PageInfo pageInfo, String orderBy) {
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 10;
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andLevelNotEqualTo(Constant.ADMIN_LEVER);
        if(StringUtils.isEmpty(orderBy)) {
            PageHelper.startPage(startPage, pageSize,"createtime desc");
        }else {
            PageHelper.startPage(startPage, pageSize,orderBy);
        }
        List<User> list =  userMapper.selectByExample(example);
        return new PageInfo<>(list);
    }

    public void insert(User user)
	{
        user.setCreatetime(new Date());
        user.setAlterime(new Date());
		userMapper.insertSelective(user);
	}


    @Override
    public int delete(Integer id, String reason){
        User user = userMapper.selectByPrimaryKey(id);
        if(null == user || user.getDeleted()){
            return -1;
        }
        user.setDeleted(true);
        int i = userMapper.updateByPrimaryKeySelective(user);
        if(i < 1){
            return -2;
        }

        logService.insert("用户"+user+"\n被冻结" + "原因为:"+reason);
        String adminMail = basicSetService.getMail();
        final String subject = "冻结通知";
        final String message = "你的论坛账号被冻结！原因为:"+reason + "\n 如需解除冻结,请及时联系管理员:"+adminMail;
        final String mail = user.getMail();
        new Thread() {
            @Override
            public void run() {
                try {
                    MailUtils.sendMail(mail, subject, message);
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }
        }.start();
        return i;
    }

    public int update(User user)
	{
        user.setAlterime(new Date());
        return userMapper.updateByPrimaryKeySelective(user);

    }

    public int updateBasicInfo(User user){
        setFieldNull(user);
        user.setAlterime(new Date());
        return userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 设置不可更改字段为空
     * @param user
     */
    private void setFieldNull(User user){
        user.setUsername(null);
        user.setPassword(null);
        user.setMail(null);
        user.setCreatetime(null);
        user.setDeleted(null);
        user.setQuestionNum(null);
        user.setPostNum(null);
        user.setScore(null);
    }

	public User getUserById(Integer id)
	{
        return userMapper.selectByPrimaryKey(id);
	}

    /**
     * 检测用户名
     * @param username
     * @return
     */
	public int checkUsername(String username)
	{
		int flag = Constant.True;
		UserExample example = new UserExample();
		example.createCriteria().andUsernameEqualTo(username);
		List<User> list = userMapper.selectByExample(example);
		if (list.size() > 0)
		{
			flag = Constant.False;
		}
		return flag;
	}

	public int checkMail(String mail)
	{
		int flag = Constant.True;
		User user = new User();
		user.setMail(mail);
		UserExample example = new UserExample();
		example.createCriteria().andMailEqualTo(mail);
		List<User> list = userMapper.selectByExample(example);
		if (list.size() > 0)
		{
			flag = Constant.False;
		}
		return flag;
	}

	public User login(User user)
	{
		UserExample example = new UserExample();
		example.createCriteria().andUsernameEqualTo(user.getUsername());
		List<User> list = userMapper.selectByExample(example);
		if (list.size() > 0)
		{
			String password = user.getPassword();
			// 加密密码
			password = EncryptUtils.encryptPassword(password,user.getUsername());
			if (list.get(0).getPassword().equals(password))
			{
			    User logUser = list.get(0);
			    // 更新最后登陆时间
                logUser.setLastLoginTime(new Date());
                userMapper.updateByPrimaryKeySelective(logUser);
				return logUser;
			}
		}
		return null;
	}

    @Override
    public List<User> listCandidateBoarder() {
        // 查找出已成为版主的用户
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andLevelEqualTo(Constant.USER_LEVEL );
        criteria.andDeletedEqualTo(false);
        criteria.andPostNumGreaterThanOrEqualTo(555);
        PageHelper.startPage(1,20,"createtime desc");
        return userMapper.selectByExample(userExample);
    }

    /**
     * 添加版主权限
     * @param user
     */
    @Override
    public void alterUserToBoarder(User user) {
        System.out.println(user);
        user.setLevel(Constant.BOARDER_LEVEL);
        System.out.println(user);
        user.setAlterime(new Date());
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public void alterUserToBoarder(Integer userId) {
        User user = userMapper.selectByPrimaryKey(userId);
        if(null == user){
            return;
        }
        this.alterUserToBoarder(user);
    }

    /**
     * 取消用户版主权限
     * @param user
     */
    @Override
    public void alterBoardToUser(User user) {
        alterBoardToUser(user.getId());
    }

    @Override
    public void alterBoardToUser(Integer userId) {
        User user = userMapper.selectByPrimaryKey(userId);
        if(null == user){
            return;
        }
        user.setLevel(Constant.USER_LEVEL);
        // 记录日志
        String content = "取消"+user.toString()+"版主权限";
        logService.insert(content);
        this.update(user);
    }

    @Override
    public int launchUser(Integer userId,String reason) {
        User user = userMapper.selectByPrimaryKey(userId);
        if(null == user || !user.getDeleted()){
            return -1;
        }
        user.setDeleted(false);
        int i = userMapper.updateByPrimaryKeySelective(user);
        if(i < 1){
            return -2;
        }

        logService.insert("用户"+user+"\n被启用" + "原因为:"+reason);
        final String subject = "冻结通知";
        final String message = "你的论坛账号已重新启用！账户名为：" +user.getUsername();
        final String mail = user.getMail();
        new Thread() {
            @Override
            public void run() {
                try {
                    MailUtils.sendMail(mail, subject, message);
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }
        }.start();
        return i;
    }

    /**
     * 获取管理员
     * @return
     */
    @Override
    public User getAdmin() {
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andLevelEqualTo(2);
        List<User> users = userMapper.selectByExample(example);
        if(null != users && users.size() > 0){
            return users.get(0);
        }
        System.err.println("无管理员账号");
        return null;
    }

}
