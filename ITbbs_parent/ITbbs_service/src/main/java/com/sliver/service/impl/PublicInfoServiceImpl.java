package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.mapper.PublicInfoMapper;
import com.sliver.pojo.PublicInfo;
import com.sliver.pojo.PublicInfoExample;
import com.sliver.service.PublicInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class PublicInfoServiceImpl implements PublicInfoService{
    @Autowired
    private PublicInfoMapper publicInfoMapper;

    @Override
    public PageInfo<PublicInfo> list(PageInfo pageInfo) {
        PublicInfoExample example = new PublicInfoExample();
        PublicInfoExample.Criteria criteria = example.createCriteria();
        String orderBy = "createtime desc";
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 20;
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<PublicInfo> list =  publicInfoMapper.selectByExample(example);
        return new PageInfo<>(list);
    }

    @Override
    public PublicInfo getPublicInfoById(Integer id) {
        return publicInfoMapper.selectByPrimaryKey(id);
    }

    @Override
    public int insert(PublicInfo publicInfo) {
        publicInfo.setCreatetime(new Date());
        return publicInfoMapper.insertSelective(publicInfo);
    }

    @Override
    public int delete(Integer publicInfoId) {
        return publicInfoMapper.deleteByPrimaryKey(publicInfoId);
    }

    @Override
    public int update(PublicInfo publicInfo) {
        publicInfo.setAltertime(new Date());
        return publicInfoMapper.updateByPrimaryKeySelective(publicInfo);
    }

    @Override
    public List<PublicInfo> listForIndex() {
        PublicInfoExample example = new PublicInfoExample();
        example.setOrderByClause("altertime  desc ,createtime DESC");
        PublicInfoExample.Criteria criteria = example.createCriteria();
        PageHelper.startPage(1,6,"altertime  desc ,createtime DESC");
        return publicInfoMapper.selectByExample(example);
    }
}
