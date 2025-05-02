#!/bin/bash

APP_NAME="simple-python-pyinstaller-app"

echo "[+] Deteniendo y eliminando contenedor: $APP_NAME-container"
docker stop $APP_NAME-container
docker rm $APP_NAME-container
