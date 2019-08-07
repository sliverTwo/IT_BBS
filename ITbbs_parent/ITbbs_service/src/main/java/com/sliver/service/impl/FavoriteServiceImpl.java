package com.sliver.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sliver.common.utils.IDUtils;
import com.sliver.mapper.FavoriteMapper;
import com.sliver.mapper.FavoriteVoMapper;
import com.sliver.pojo.*;
import com.sliver.pojo.Favorite;
import com.sliver.pojo.FavoriteExample;
import com.sliver.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    private FavoriteMapper favoriteMapper;
    @Autowired
    private FavoriteVoMapper favoriteVoMapper;

    private FavoriteExample example = new FavoriteExample();

    @Override
    public int insert(Favorite favorite) {
        favorite.setId(IDUtils.getUUID());
        favorite.setCreatetime(new Date());
        return favoriteMapper.insert(favorite);
    }

    @Override
    public int delete(Favorite favorite) {
        return favoriteMapper.deleteByPrimaryKey(favorite.getId());
    }

    @Override
    public int delete(String postId) {
        example.clear();
        FavoriteExample.Criteria criteria = example.createCriteria();
        criteria.andPostIdEqualTo(postId);
        return favoriteMapper.deleteByExample(example);
    }

    @Override
    public PageInfo<FavoriteVo> listFavoriteByUserId(Integer userId,PageInfo pageInfo) {
        FavoriteVoExample favoriteVoExample = new FavoriteVoExample();
        FavoriteVoExample.Criteria criteria = favoriteVoExample.createCriteria();
        criteria.andFavoriteUserIdEqualTo(userId);
        String orderBy = "createtime desc";
        int startPage = pageInfo.getNextPage() != 0 ? pageInfo.getNextPage() : 1;
        int pageSize = pageInfo.getPageSize() != 0 ? pageInfo.getPageSize() : 20;
        PageHelper.startPage(startPage, pageSize,orderBy);
        List<FavoriteVo> favorites = favoriteVoMapper.selectByExample(favoriteVoExample);
        return  new PageInfo(favorites);
    }

    @Override
    public Favorite getFavoriteById(String favoriteId) {
        return favoriteMapper.selectByPrimaryKey(favoriteId);
    }

    @Override
    public Favorite getFavoriteByuIdAndPId(Integer userId, String postId) {
        example.clear();
        FavoriteExample.Criteria criteria = example.createCriteria();
        criteria.andPostIdEqualTo(postId);
        criteria.andUserIdEqualTo(userId);
        List<Favorite> favorites = favoriteMapper.selectByExample(example);
        if(null == favorites || favorites.size() == 0){
            return null;
        }
        return favorites.get(0);
    }

    @Override
    public int deleteByPostId(String postId) {
        example.clear();
        FavoriteExample.Criteria criteria = example.createCriteria();
        criteria.andPostIdEqualTo(postId);
        return favoriteMapper.deleteByExample(example);
    }

}
