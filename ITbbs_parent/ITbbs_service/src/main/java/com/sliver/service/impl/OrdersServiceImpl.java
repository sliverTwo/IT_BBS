package com.sliver.service.impl;

import com.sliver.common.utils.IDUtils;
import com.sliver.common.utils.StringUtils;
import com.sliver.mapper.OrdersMapper;
import com.sliver.mapper.ScoreLogMapper;
import com.sliver.pojo.Orders;
import com.sliver.pojo.ScoreLog;
import com.sliver.pojo.User;
import com.sliver.service.OrdersService;
import com.sliver.service.ScoreLogService;
import com.sliver.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class OrdersServiceImpl implements OrdersService {
    @Autowired
    private OrdersMapper ordersMapper;
    @Autowired
    private ScoreLogService scoreLogService;
    @Autowired
    private UserService userService;

    @Override
    public int insert(Orders order) {
        order.setCreatetime(new Date());
        String userId = order.getOrderId();
        String id = order.getOrderId();
        Float money = order.getMoney();
        Integer score = order.getScore();
        if(StringUtils.isEmpty(userId,id,money.toString(),score.toString())){
            return 0;
        }
        return ordersMapper.insertSelective(order);
    }

    @Override
    public int finishOrders(Orders orders) {
        Date now = new Date();
        if(StringUtils.isEmpty(orders.getOrderId())){
            return 0;
        }
        Orders o = ordersMapper.selectByPrimaryKey(orders.getOrderId());
        if(null == o){
            return 0;
        }
        if(StringUtils.isEmpty(orders.getFinished().toString())){
            return 0;
        }
        // 防止二次发放积分
        if(null != o.getFinished() && o.getFinished()){
            return  1;
        }
        o.setFinished(orders.getFinished());
        if(orders.getFinished()){
            o.setFinishedTime(now);
            // 记录日志
            scoreLogService.insert("充值积分",o.getScore(),o.getUserId());
            // 增加用户积分
            User user = userService.getUserById(o.getUserId());
            user.setScore(user.getScore() + o.getScore());
            userService.update(user);
        }
        return ordersMapper.updateByPrimaryKey(o);
    }
}
