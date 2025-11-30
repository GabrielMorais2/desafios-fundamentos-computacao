#!/bin/sh

while true; do
  echo "== $(date) =="
  echo "Fazendo requisição para http://app:8080/hello"
  curl -s http://app:8080/hello
  echo ""
  sleep 5
done
