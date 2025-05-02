FROM python:3.13-alpine

WORKDIR /app

# Copiamos el ejecutable creado con PyInstaller
COPY dist/main /app/main

# Damos permisos de ejecución y lo ejecutamos
ENTRYPOINT ["./main"]
