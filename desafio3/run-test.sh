#!/bin/bash

LOG_FILE="logs.txt"
ENDPOINT="http://localhost:8080/v1/message"

echo "===========================================" | tee $LOG_FILE
echo "🚀 Iniciando teste do Desafio 3" | tee -a $LOG_FILE
echo "===========================================" | tee -a $LOG_FILE

echo ""
echo "🔧 Subindo containers..."
docker-compose up -d --build >> $LOG_FILE 2>&1

echo ""
echo "⏳ Aguardando aplicação iniciar..."
RETRIES=60
until curl -s $ENDPOINT > /dev/null || [ $RETRIES -eq 0 ]; do
  sleep 1
  RETRIES=$((RETRIES-1))
done

if [ $RETRIES -eq 0 ]; then
  echo "❌ A aplicação não subiu. Verifique logs."
  docker logs spring-app | tee -a $LOG_FILE
  exit 1
fi

echo "✅ Aplicação respondeu!"

# 🔹 Executando as requisições normalmente
echo ""
echo "🔍 Chamadas para o endpoint"
curl -s $ENDPOINT > /dev/null
curl -s $ENDPOINT > /dev/null
curl -s $ENDPOINT > /dev/null

echo ""
echo "🛑 Capturando TODOS os logs do container SPRING-APP"
docker logs spring-app >> $LOG_FILE 2>&1

echo ""
echo "🛑 Derrubando containers..."
docker-compose down >> $LOG_FILE 2>&1

echo ""
echo "🎉 Teste finalizado! Todos os logs foram salvos em: $LOG_FILE"
echo "==========================================="
