package com.sliver.service;

import com.sliver.pojo.Orders;

public interface OrdersService {
    int insert(Orders order);
    int finishOrders(Orders orders);
}
