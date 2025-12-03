package com.desafio.cesar.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@RestController
public class UserController {

    @GetMapping("/v1/users")
    public List<UserResponse> getUsers() {
        return List.of(
                new UserResponse(1L, "Gabriel", "2020-01-01"),
                new UserResponse(2L, "Maria", "2021-03-10"),
                new UserResponse(3L, "João", "2022-07-15")
        );
    }

    @Data
    @AllArgsConstructor
    static class UserResponse {
        private Long id;
        private String name;
        private String activeSince;
    }
}