package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.utils.IDUtils;
import com.sliver.mapper.FileMapper;
import com.sliver.mapper.ScoreLogMapper;
import com.sliver.pojo.File;
import com.sliver.pojo.FileExample;
import com.sliver.pojo.ScoreLog;
import com.sliver.pojo.User;
import com.sliver.service.FileService;
import com.sliver.service.ScoreLogService;
import com.sliver.service.UserService;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * 文件Service
 *
 */
@Service
public class FileServiceImpl implements FileService {
    @Autowired
    private FileMapper fileMapper;
    @Autowired
    private UserService userService;
    @Autowired
    private ScoreLogService scoreLogService;
    @Override
    public int insert(File file) {
        file.setCreatetime(new Date());
        file.setDownloadNum(0);
        return fileMapper.insertSelective(file);
    }


    @Override
    public int delete(String fileId) {

        return fileMapper.deleteByPrimaryKey(fileId);
    }

    @Override
    public PageInfo listByUserId(Integer userId,PageInfo pageInfo) {
        FileExample example = new FileExample();
        FileExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdEqualTo(userId);
        String orderBy = "createtime desc";
        return listByExample(example,orderBy,pageInfo);
    }

    @Override
    public File getFileById(String id) {
        return fileMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo list(PageInfo pageInfo) {
        FileExample example = new FileExample();
        FileExample.Criteria criteria = example.createCriteria();
        String orderBy = "createtime desc";
        return listByExample(example,orderBy,pageInfo);
    }

    @Override
    public void downloadFile(Integer userId, String fileId) {
        User user = userService.getUserById(userId);
        File file = fileMapper.selectByPrimaryKey(fileId);
        User owner = userService.getUserById(file.getUserId());
        if(user.getId().equals(owner.getId())){
            return;
        }
        // 增加下载数
        file.setDownloadNum(file.getDownloadNum() + 1);
        // 扣除下载用户积分
        user.setScore(user.getScore() - file.getScore());
        // 增加文件所属用户积分
        owner.setScore(owner.getScore() + file.getScore());
        // 写日志
        // 持久化
        Integer score = file.getScore();
        scoreLogService.insert("下载文件"+file.getFilename(),-score, user.getId());
        scoreLogService.insert(owner.getUsername()+ "下载文件"+file.getFilename(),score,owner.getId());
        fileMapper.updateByPrimaryKeySelective(file);
        userService.update(user);
        userService.update(owner);
    }

    private PageInfo listByExample(FileExample fileExample, String orderBy, PageInfo pageInfo){
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 20;
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<File> list =  fileMapper.selectByExample(fileExample);
        return new PageInfo<>(list);
    }
}
