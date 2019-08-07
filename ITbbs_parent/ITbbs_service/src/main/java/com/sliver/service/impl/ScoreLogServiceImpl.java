package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.utils.IDUtils;
import com.sliver.common.utils.NullUtils;
import com.sliver.mapper.ScoreLogMapper;
import com.sliver.pojo.ScoreLogExample;
import com.sliver.pojo.ScoreLog;
import com.sliver.pojo.User;
import com.sliver.service.ScoreLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ScoreLogServiceImpl implements ScoreLogService {
    @Autowired
    private ScoreLogMapper scoreLogMapper;

    @Override
    public void insert(String content, Integer score, Integer userId) {
        if(NullUtils.isNull(content,score,userId)){
            return;
        }
        ScoreLog scoreLog = new ScoreLog();
        scoreLog.setCreatetime(new Date());
        scoreLog.setContent(content);
        scoreLog.setUserId(userId);
        scoreLog.setScore(score);
        scoreLog.setId(IDUtils.getUUID());
        scoreLogMapper.insertSelective(scoreLog);
    }

    @Override
    public PageInfo<ScoreLog> listLog(User user, PageInfo pageInfo) {
        ScoreLogExample example = new ScoreLogExample();
        ScoreLogExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdEqualTo(user.getId());
        String orderBy = "createtime desc";
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 20;
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<ScoreLog> list =  scoreLogMapper.selectByExample(example);
        return new PageInfo<>(list);
    }
}
