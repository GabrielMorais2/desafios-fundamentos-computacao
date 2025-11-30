#!/bin/bash

LOG_FILE="logs.txt"

# Limpa arquivo de log anterior
echo "🧹 Limpando logs anteriores..." | tee $LOG_FILE

echo "🚀 Subindo containers..." | tee -a $LOG_FILE
docker compose up -d 2>&1 | tee -a $LOG_FILE

echo "⏳ Aguardando PostgreSQL iniciar..." | tee -a $LOG_FILE
sleep 10

echo "📝 Inserindo novo dado no banco..." | tee -a $LOG_FILE
docker exec -i pg-demo psql -U admin -d demo -c \
  "INSERT INTO messages (text) VALUES ('Valor inserido antes de apagar o container');" \
  2>&1 | tee -a $LOG_FILE

echo "📌 Listando dados antes de remover o container:" | tee -a $LOG_FILE
docker exec -i pg-demo psql -U admin -d demo -c "SELECT * FROM messages;" \
  2>&1 | tee -a $LOG_FILE

echo "🛑 Removendo container..." | tee -a $LOG_FILE
docker compose down 2>&1 | tee -a $LOG_FILE

echo "🔁 Subindo novamente..." | tee -a $LOG_FILE
docker compose up -d 2>&1 | tee -a $LOG_FILE

echo "⏳ Aguardando re-subida..." | tee -a $LOG_FILE
sleep 8

echo "📌 Listando dados após recriar o container:" | tee -a $LOG_FILE
docker exec -i pg-demo psql -U admin -d demo -c "SELECT * FROM messages;" \
  2>&1 | tee -a $LOG_FILE

echo "🎉 Teste concluído! Dados persistiram!" | tee -a $LOG_FILE
