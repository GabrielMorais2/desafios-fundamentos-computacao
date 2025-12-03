package com.desafio.cesar.demo.repository;

import com.desafio.cesar.demo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {}
