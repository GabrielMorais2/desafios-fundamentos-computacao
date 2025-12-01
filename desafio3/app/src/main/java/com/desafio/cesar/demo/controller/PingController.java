package com.desafio.cesar.demo.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class PingController {

    @GetMapping("/ping")
    public String ping() {
        return "Web OK!";
    }
}
