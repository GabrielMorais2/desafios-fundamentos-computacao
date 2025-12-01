package com.desafio.cesar.demo.repository;

import com.desafio.cesar.demo.model.Message;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MessageRepository extends JpaRepository<Message, Long> {
}