#!/bin/bash

APP_NAME="simple-python-pyinstaller-app"

echo "[+] Construyendo imagen Docker: $APP_NAME"
docker build -t $APP_NAME .

echo "[+] Ejecutando contenedor $APP_NAME"
docker run -d --name $APP_NAME-container $APP_NAME
