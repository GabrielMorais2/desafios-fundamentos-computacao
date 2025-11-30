# README — Desafio 1: Containers em Rede

**Projeto:** `desafio-network`  
**Stack principal:** Java 21, Spring Boot, Gradle, Docker, Docker Compose, Alpine (checker + curl)  
**Objetivo:** Dois containers comunicando-se por uma rede Docker nomeada: um *app* (servidor Java) e um *checker* (faz requisições periódicas). Inclui scripts para subir, colher logs e parar automaticamente.

---

# 1. Descrição da solução & decisões técnicas

**Resumo da solução**
- `app` — aplicação Spring Boot rodando em **Java 21** que expõe `GET /hello` em `:8080`.
- `checker` — container minimal (Alpine) com um script `loop.sh` que faz `curl` para `http://app:8080/hello` a cada 5s e imprime a resposta.
- Rede Docker nomeada: `desafio_network_custom` (definida no `docker-compose.yml`).

**Decisões técnicas**
- **Java 21**: escolhido por requisito (seu pedido). Dockerfile usa Eclipse Temurin 21 no runtime.
- **Gradle / bootJar**: build via Gradle — atenção à compatibilidade Spring Boot vs versão do Gradle.
    - Se usar **Spring Boot 4.0.0**, a imagem de build precisa ser `gradle:8.14-jdk21` (ou superior).
    - Alternativa: usar **Spring Boot 3.x** com `gradle:8.7-jdk21` se não quiser atualizar imagem.
- **Docker multi-stage**: build do jar no stage `build` e runtime minimal no stage `runtime` (reduz imagem final).
- **docker-compose**: orquestra os containers e cria a rede nomeada.
- **Logs**: scripts para coletar logs (`run_and_collect.sh`, `logs.sh`). `docker compose logs` reúne logs de todos os serviços.
- **Simplicidade e portabilidade**: uso de Alpine para checker mantém imagem pequena; comunicação interna via nome de serviço `app` (DNS do Docker Compose).

---

# 2. Arquitetura e funcionamento detalhado

```
[Host]  <--(porta 8080 opcional)-->  Docker network (desafio_network_custom)
                                    ├── app_service (container)  -> Spring Boot (porta 8080)
                                    └── checker_service (container) -> loop curl -> http://app:8080/hello
```

**Fluxos principais**
1. **Build & Run**
    - `docker-compose` constrói a imagem `app` (Gradle bootJar) e a imagem `checker`.
    - `docker-compose up` cria a rede `desafio_network_custom` e conecta ambos serviços a ela.

2. **Comunicação entre containers**
    - `checker` resolve `app` via DNS interno e faz `curl http://app:8080/hello`.
    - `app` responde com uma string contendo timestamp.

3. **Logs**
    - `checker` imprime cada tentativa e a resposta.
    - `docker compose logs` reúne logs dos dois serviços.
    - `run_and_collect.sh` cria arquivo `logs.txt` automaticamente.

---

# 3. Instruções de execução (passo-a-passo)

## Subir o projeto
```
docker compose up --build -d
```

## Ver logs
```
docker compose logs -f
```

## Script automático (sobe → espera 15s → salva logs → derruba)
```
./run_and_collect.sh
```

Logs serão salvos em `logs.txt`.

---

# 4. Exemplo de logs
```
checker_service  | === checking http://app:8080/hello ===
checker_service  | Resposta do servidor Java...
app_service      | GET /hello served
```

---

# 5. Troubleshooting
- Erro de Gradle/Spring Boot → usar `gradle:8.14-jdk21` para Spring Boot 4.
- Comunicação falhando → verificar rede `desafio_network_custom`.
- `settings.gradle not found` → verificar contexto do build no Dockerfile.

---

# 6. Critérios atendidos
- Rede Docker configurada ✔
- Comunicação funcional ✔
- README detalhado ✔
- Scripts e organização ✔
