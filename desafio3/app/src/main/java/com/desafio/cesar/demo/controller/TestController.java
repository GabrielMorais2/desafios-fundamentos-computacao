package com.desafio.cesar.demo.controller;

import com.desafio.cesar.demo.model.Message;
import com.desafio.cesar.demo.repository.MessageRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;
import tools.jackson.databind.ObjectMapper;

import java.util.List;

@RestController
@RequestMapping("/v1/message")
@RequiredArgsConstructor
@Slf4j
public class TestController {

    private final StringRedisTemplate redisTemplate;
    private final MessageRepository messageRepository;
    private final ObjectMapper objectMapper;

    @GetMapping
    public List<Message> db() {
        String cacheKey = "messages:all";

        try {
            log.info("🔎 Verificando se existe cache em Redis para key '{}'", cacheKey);
            String cachedJson = redisTemplate.opsForValue().get(cacheKey);

            if (cachedJson != null) {
                log.info("🔵 CACHE encontrado. Retornando dados do Redis ({} bytes)", cachedJson.length());
                return List.of(objectMapper.readValue(cachedJson, Message[].class));
            }

            log.info("⚠️ CACHE não encontrado. Buscando dados no POSTGRES...");
            List<Message> messages = messageRepository.findAll();
            log.info("🟢 Dados obtidos do POSTGRES. Total de registros: {}", messages.size());

            String json = objectMapper.writeValueAsString(messages);
            redisTemplate.opsForValue().set(cacheKey, json);
            log.info("✅ Dados armazenados no Redis com key '{}'", cacheKey);

            return messages;

        } catch (Exception e) {
            log.error("❌ Erro ao processar mensagens", e);
            throw new RuntimeException("Erro interno ao acessar mensagens");
        }
    }
}
