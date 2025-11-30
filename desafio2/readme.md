
# Desafio 2 — Volumes e Persistência (Documentação)

## 📘 Objetivo
Demonstrar como dados podem persistir mesmo após a remoção de containers utilizando **volumes Docker**. O desafio mostra que o volume é separado do ciclo de vida do container e permanece salvo no host.

---

## 🏗️ Arquitetura Geral da Solução

A solução consiste basicamente em:

### ✔ 1. Um container rodando PostgreSQL
Esse container é responsável por subir o banco e executa um script inicial para criar a tabela e inserir registros exemplo.

### ✔ 2. Um volume Docker persistente
Ele armazena os dados reais do banco.  
Mesmo após remover o container, o volume continua existindo e pode ser reutilizado.

### ✔ 3. Um script de teste automatizado (`test.sh`)
Esse script demonstra claramente a persistência dos dados seguindo o fluxo:
1. Sobe o container.
2. Aguarda inicialização do PostgreSQL.
3. Insere registros.
4. Lista os dados.
5. Derruba e remove o container.
6. Sobe novamente.
7. Mostra que os dados persistem.
8. Salva todos os logs em `logs.txt`.

---

## 🔍 Funcionamento do Fluxo

### 1. Subir o banco pela primeira vez
O Docker cria o volume automaticamente.  
O PostgreSQL executa o arquivo de inicialização contendo a criação da tabela e os inserts.

### 2. Inserir dados
Mesmo que os containers sejam destruídos, os arquivos de dados continuam armazenados dentro do volume, localizado no host.

### 3. Remover e recriar container
Quando o container é refeito usando o mesmo volume:
- Nenhum dado se perde.
- O banco volta com os registros existentes.

---

## ▶️ Como Executar o Projeto

### **1. Dê permissão ao script**
No Linux ou WSL:
```
chmod +x test.sh
```

### **2. Execute o teste completo**
```
./test.sh
```

### **3. Verifique os logs**
Todo o processo é salvo automaticamente:
```
logs.txt
```

Nesse arquivo, você verá:
- A inicialização do sistema
- Os comandos SQL executados
- Os dados antes e depois da recriação do container
- A prova final de persistência

---

## Conclusão

Esse desafio demonstra de forma prática que:
- Volumes Docker são a solução recomendada para persistir dados.
- Contêineres podem ser descartados sem perda de informações.
- O banco pode ser reconstruído facilmente, mantendo o estado anterior.

A persistência foi comprovada com sucesso através do script automatizado.


