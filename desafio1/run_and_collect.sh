#!/bin/bash

echo "🚀 Subindo containers..."
docker compose up -d

echo "⏳ Aguardando 15 segundos para coleta de logs..."
sleep 15

echo "📄 Coletando logs..."
docker compose logs > logs.txt

echo "🧹 Derrubando containers..."
docker compose down

echo "✅ Processo concluído!"
echo "Logs salvos em: $(pwd)/logs.txt"
