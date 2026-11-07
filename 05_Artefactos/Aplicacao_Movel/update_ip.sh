#!/bin/bash

# Descobre automaticamente o IP ativo na placa de rede Wi-Fi do Mac (en0)
LOCAL_IP=$(ipconfig getifaddr en0)

# Se o en0 não estiver ativo, tenta o en1 por segurança
if [ -z "$LOCAL_IP" ]; then
  LOCAL_IP=$(ipconfig getifaddr en1)
fi

if [ -z "$LOCAL_IP" ]; then
  echo "❌ Erro: Não foi possível detetar nenhum IP de rede ativa. Verifique a sua ligação Wi-Fi."
  exit 1
fi

# Escreve o IP detetado automaticamente no ficheiro .env
echo "API_BASE_URL=http://$LOCAL_IP:3000/api/users" > .env

echo "✅ Ficheiro .env atualizado com sucesso!"
echo "🌐 IP configurado: $LOCAL_IP"
echo "🚀 Agora já pode correr 'flutter run' manualmente ou usar o botão de Play do seu editor!"