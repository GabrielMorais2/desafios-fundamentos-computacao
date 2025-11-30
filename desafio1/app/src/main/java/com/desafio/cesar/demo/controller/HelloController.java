package com.desafio.cesar.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Resposta do servidor Java. Timestamp: " + Instant.now();
    }
}
