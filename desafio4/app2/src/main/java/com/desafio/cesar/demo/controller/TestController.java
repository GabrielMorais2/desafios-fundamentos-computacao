package com.desafio.cesar.demo.controller;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

@RestController
@RequiredArgsConstructor
@Slf4j
public class TestController {

    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/v1/message")
    public List<CombinedMessage> getMessages() {

        log.info("📡 Chamando Microsserviço A para obter usuários...");

        String url = "http://spring-app1:8080/v1/users";

        UserResponse[] users = restTemplate.getForObject(url, UserResponse[].class);

        log.info("✅ Usuários recebidos: {}", users != null ? users.length : 0);

        return Arrays.stream(users)
                .map(u -> new CombinedMessage(
                        u.getName(),
                        "Usuário " + u.getName() + " ativo desde " + u.getActiveSince()
                ))
                .toList();
    }

    @Data
    static class CombinedMessage {
        private final String user;
        private final String message;
    }

    @Data
    static class UserResponse {
        private Long id;
        private String name;
        private String activeSince;
    }
}