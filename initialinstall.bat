@echo off

setlocal EnableDelayedExpansion

echo "Iniciando a instalação das ferramentas..."

echo "Instalando o Chocolatey (se ainda não estiver instalado)..."
IF NOT EXIST "%ProgramData%\chocolatey" (
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
)

set "programs=jetbrainstoolbox vscode dbeaver github-desktop notion git nvm docker-desktop bitwarden authy googlechrome brave postman insomnia-rest-api-client"

for %%p in (%programs%) do (
    echo "Instalando %%p..."
    choco install %%p -y || goto error
)

echo "Todas as ferramentas foram instaladas com sucesso!"
goto end

:error
echo "Ocorreu um erro durante a instalação. Verifique as mensagens acima para mais informações."
exit /b 1

:end
pause

