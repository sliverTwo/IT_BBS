package com.sliver.service.impl;

import com.sliver.common.utils.IDUtils;
import com.sliver.pojo.Log;
import com.sliver.service.LogService;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class LogServiceImpl implements LogService {


    @Override
    public void insert(String content) {
        if(null == content){
            return;
        }
        Log log = new Log();
        log.setContent(content);
        log.setCreateTime(new Date());
        log.setId(IDUtils.getUUID());
    }
}
