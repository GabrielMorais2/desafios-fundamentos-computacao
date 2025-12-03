package com.desafio.cesar.demo.repository;

import com.desafio.cesar.demo.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {}