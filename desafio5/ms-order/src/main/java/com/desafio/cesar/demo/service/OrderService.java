package com.desafio.cesar.demo.service;

import com.desafio.cesar.demo.model.Order;
import com.desafio.cesar.demo.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository repository;

    public List<Order> findAll() {
        return repository.findAll();
    }

    public Order save(Order order) {
        return repository.save(order);
    }
}