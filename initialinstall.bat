@echo off

setlocal EnableDelayedExpansion

echo "Iniciando a instalação das ferramentas..."

echo "Instalando o Chocolatey (se ainda não estiver instalado)..."
IF NOT EXIST "%ProgramData%\chocolatey" (
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
)

set "programs=jetbrainstoolbox vscode dbeaver github-desktop notion git nvm docker-desktop bitwarden authy googlechrome brave postman insomnia-rest-api-client office365business"

for %%p in (%programs%) do (
    echo "Instalando %%p..."
    choco install %%p -y || goto error
)

echo "Montando o ambinete docker"
echo "Postgres"
docker run --restart always --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres

echo "MariaDB"
docker run --restart always -d --name mariadb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mariadb mariadb


echo "Todas as ferramentas foram instaladas com sucesso!"
goto end

:error
echo "Ocorreu um erro durante a instalação. Verifique as mensagens acima para mais informações."
exit /b 1

:end
pause

