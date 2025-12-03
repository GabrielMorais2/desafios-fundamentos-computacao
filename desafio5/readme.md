# 📘 Microsserviços com API Gateway — Desafio 5

## 🏗️ Visão Geral

Este projeto implementa uma arquitetura de microsserviços utilizando um API Gateway para centralizar o acesso aos serviços internos. A solução contempla:

- **users-service**: Microsserviço responsável pela gestão de usuários.
- **orders-service**: Microsserviço responsável pela gestão de pedidos.
- **gateway**: Centraliza e orquestra todas as chamadas aos microsserviços.
- **docker-compose**: Orquestração opcional e simples dos três serviços.

O objetivo é demonstrar uma arquitetura distribuída, modular, escalável e de fácil evolução, utilizando tecnologias como Spring Boot, Spring MVC, Spring Data JPA, Lombok e Java 23.

## 📐 Arquitetura da Solução


## 🔹 1. API Gateway

O gateway atua como uma fachada entre o cliente e os microsserviços internos, simplificando o acesso e adicionando camadas de abstração.

**Funções principais:**
- Expor endpoints unificados:
    - GET /users
    - GET /users/{id}
    - POST /users
    - GET /orders
    - POST /orders
- Encaminhar requisições para os microsserviços corretos.
- Padronizar rotas.
- Permitir evoluções futuras, como autenticação, logs, cache e rate-limiting.

## 🔹 2. Microsserviço de Usuários (users-service)

**Endpoints implementados:**

| Método | Rota         | Descrição                  |
|--------|--------------|----------------------------|
| GET    | /users      | Retorna todos os usuários  |
| GET    | /users/{id} | Busca um usuário por ID    |
| POST   | /users      | Cria um novo usuário       |

**Exemplo de Payload (POST /users):**

````json
 { "name": "Alice" }
````


## 🔹 3. Microsserviço de Pedidos (orders-service)

**Endpoints implementados:**

| Método | Rota     | Descrição             |
|--------|----------|-----------------------|
| GET    | /orders | Lista todos os pedidos|
| POST   | /orders | Cria um novo pedido   |

**Exemplo de Payload (POST /orders):**

````json
 { "userId": 1, "total": 99.90 }
````


## 🔄 Comunicação entre os Serviços

O Gateway se comunica com os serviços via HTTP interno:

| Serviço         | URL Interna                     |
|-----------------|---------------------------------|
| users-service   | http://users-service:8081/users |
| orders-service  | http://orders-service:8082/orders |

## ⭐ Fluxos do Sistema

### ✔ Fluxo 1 — Buscar Usuários
- Cliente chama: GET http://localhost:8080/users
- Gateway encaminha para: GET http://users-service:8081/users
- Resposta retorna ao cliente.

### ✔ Fluxo 2 — Criar Pedido
- Cliente chama: POST http://localhost:8080/orders
- Gateway encaminha para: POST http://orders-service:8082/orders

## ⚙️ Decisões Técnicas

**Por que microsserviços?**
- Deploy independente.
- Escalabilidade individual.
- Facilita a manutenção.

**Por que API Gateway?**
- Torna a arquitetura externa uniforme.
- Simplifica a integração com clientes.
- Auxilia no versionamento e segurança.

**Por que Spring Boot?**
- Simples, robusto e produtivo.
- Stack madura com grande comunidade.

## ▶️ Como Executar o Projeto

### 🟦 Opção A — Rodando com Maven (sem Docker)
1. Clone o repositório:
   ```
   https://github.com/GabrielMorais2/desafios-fundamentos-computacao.git
   cd desafios-fundamentos-computacao
   ```
2. Rode cada microsserviço individualmente:
    - **Users Service**: `cd ms-users && ./mvnw spring-boot:run`
    - **Orders Service**: `cd ms-order && ./mvnw spring-boot:run`
    - **Gateway**: `cd api-gateway && ./mvnw spring-boot:run`

### 🟩 Opção B — Rodando com Docker Compose
1. Build dos serviços: `docker-compose build`
2. Suba toda a arquitetura: `docker-compose up -d`

**Portas disponíveis:**
- Gateway: 8080
- Users-service: 8081
- Orders-service: 8082

## 🧪 Testes — Exemplos com cURL

### ─────────────── USERS ───────────────
- **GET — Listar usuários**: `curl -X GET http://localhost:8080/users`
- **GET — Buscar por ID**: `curl -X GET http://localhost:8080/users/1`
- **POST — Criar usuário**:
  ```
  curl -X POST http://localhost:8080/users \
    -H "Content-Type: application/json" \
    -d '{"name":"Novo Usuário"}'
  ```

### ─────────────── ORDERS ───────────────
- **GET — Listar pedidos**: `curl -X GET http://localhost:8080/orders`
- **POST — Criar pedido**:
  ```
  curl -X POST http://localhost:8080/orders \
    -H "Content-Type: application/json" \
    -d '{"userId":1,"total":129.90}'
  ```

## 📦 Estrutura de Pacotes (Arquitetura Interna)

Cada microsserviço segue uma estrutura similar:

```css
src/main/java/com/desafio/cesar/demo/
│
├── controller/
│   ├── UserController.java
│   └── OrderController.java
│
├── service/
│   ├── UserService.java
│   └── OrderService.java
│
├── model/
│   ├── User.java
│   └── Order.java
│
└── repository/
```

**Padrão aplicado:**
- **Controller**: Endpoints REST.
- **Service**: Regras de negócio.
- **Repository**: Persistência (usando Spring Data JPA).

## 🧩 Possíveis Extensões Futuras

- Autenticação JWT.
- Rate limiting e quotas.
- Observabilidade (Prometheus + Grafana).
- Resiliência com Resilience4j.
- Descoberta de serviços (Eureka).
- Cache distribuído.
- Mensageria (Kafka / RabbitMQ).

## ✅ Conclusão

Este projeto demonstra:
- Arquitetura profissional baseada em microsserviços.
- API Gateway como centralizador.
- Microsserviços independentes e escaláveis.
- Possibilidade real de evolução.
- Código simples, organizado e modular.