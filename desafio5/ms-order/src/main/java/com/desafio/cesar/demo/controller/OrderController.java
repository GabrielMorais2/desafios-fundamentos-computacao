package com.desafio.cesar.demo.controller;

import com.desafio.cesar.demo.model.Order;
import com.desafio.cesar.demo.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService service;

    @GetMapping
    public List<Order> all() {
        return service.findAll();
    }

    @PostMapping
    public Order create(@RequestBody Order order) {
        return service.save(order);
    }
}