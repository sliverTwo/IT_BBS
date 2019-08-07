package com.sliver.service.impl;

import com.sliver.mapper.BasicSetMapper;
import com.sliver.pojo.BasicSet;
import com.sliver.pojo.BasicSetExample;
import com.sliver.service.BasicSetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BasicSetServiceImpl implements BasicSetService {

    @Autowired
    private BasicSetMapper basicSetMapper;

    @Override
    public String getMail() {

        return getValue("admin_mail");
    }

    @Override
    public void setMail(String adminMail) {
        setValue("admin_mail",adminMail);
    }

    @Override
    public String getFilterString() {
        return getValue("filter_string");
    }

    @Override
    public void setFilterString(String filterString) {
        setValue("filter_string",filterString);
    }

    @Override
    public void setValue(String setName,String setValue){
        BasicSetExample example = new BasicSetExample();
        BasicSetExample.Criteria criteria = example.createCriteria();
        criteria.andSetNameEqualTo(setName);
        BasicSet set = new BasicSet();
        set.setSetValue(setValue);
        basicSetMapper.updateByExampleSelective(set,example);
    }

    @Override
    public String getValue(String setName){
        BasicSetExample example = new BasicSetExample();
        BasicSetExample.Criteria criteria = example.createCriteria();
        criteria.andSetNameEqualTo(setName);
        List<BasicSet> basicSets = basicSetMapper.selectByExample(example);
        if(null != basicSets && basicSets.size() > 0){
            return basicSets.get(0).getSetValue();
        }
        return "";
    }
}
