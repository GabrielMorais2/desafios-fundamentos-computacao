#!/bin/bash

LOG_FILE="log.txt"

echo "============================" | tee $LOG_FILE
echo "🚀 Iniciando execução - $(date)" | tee -a $LOG_FILE
echo "============================" | tee -a $LOG_FILE

echo "📦 Subindo containers com Docker Compose..." | tee -a $LOG_FILE
docker-compose up -d --build 2>&1 | tee -a $LOG_FILE

echo "⏳ Aguardando serviços iniciarem..." | tee -a $LOG_FILE
sleep 10

echo "" | tee -a $LOG_FILE
echo "============================" | tee -a $LOG_FILE
echo "📡 Realizando requisições HTTP" | tee -a $LOG_FILE
echo "============================" | tee -a $LOG_FILE

# --- APP1 → /v1/users ---
echo "" | tee -a $LOG_FILE
echo "🔎 Requisição para APP1 (porta 8080)..." | tee -a $LOG_FILE
curl -i http://localhost:8080/v1/users 2>&1 | tee -a $LOG_FILE

# --- APP2 → /v1/message ---
echo "" | tee -a $LOG_FILE
echo "🔎 Requisição para APP2 (porta 8081)..." | tee -a $LOG_FILE
curl -i http://localhost:8081/v1/message 2>&1 | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "============================" | tee -a $LOG_FILE
echo "🧹 Finalizando e removendo containers..." | tee -a $LOG_FILE
docker-compose down -v 2>&1 | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "============================" | tee -a $LOG_FILE
echo "✅ Execução concluída - $(date)" | tee -a $LOG_FILE
echo "📄 Log gerado em: $LOG_FILE" | tee -a $LOG_FILE
