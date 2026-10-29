@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

:: Descobre o IP IPv4 da placa de rede Wi-Fi ou Ethernet ativa
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address" /c:"Endereço IPv4"') do (
    set "IP_RAW=%%a"
    :: Remove espaços em branco
    set "LOCAL_IP=!IP_RAW: =!"
    if defined LOCAL_IP goto :found
)

:found
if "%LOCAL_IP%"=="" (
    echo ❌ Erro: Não foi possível detetar nenhum IP de rede ativa. Verifique a sua ligação à rede.
    exit /b 1
)

:: Escreve o IP detetado automaticamente no ficheiro .env
echo API_BASE_URL=http://%LOCAL_IP%:3000/api/users> .env

echo ✅ Ficheiro .env atualizado com sucesso!
echo 🌐 IP configurado: %LOCAL_IP%
echo 🚀 Agora já pode correr 'flutter run' manualmente ou usar o botão de Play do seu editor!