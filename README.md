# Despliegue de Jenkins + Aplicación Python

Este proyecto automatiza el despliegue de un entorno Jenkins personalizado para ejecutar pipelines de CI/CD con una aplicación Python.

---

## 1. Crear imagen personalizada de Jenkins

Desde el directorio `docs/`, construye la imagen Docker personalizada:

```bash
cd docs
docker build -t myjenkins-blueocean .
```

---

## 2. Desplegar contenedores con Terraform

Este paso lanza la infraestructura necesaria utilizando Terraform. El siguiente script automatiza los comandos de inicialización, validación y despliegue del entorno definido:

```bash
python ./deploy_jenkins.py
```

Este script realiza lo siguiente:

1. Inicializa el directorio de trabajo de Terraform (terraform init).

2. Valida que los archivos de configuración sean correctos (terraform validate).

3. Aplica automáticamente la infraestructura sin requerir confirmación manual (terraform apply -auto-approve).

---

## 3. Configuración inicial de Jenkins

1. Abre tu navegador en: http://localhost:8080
2. Se te pedirá una contraseña de administrador.

### Obtener la contraseña inicial

1. Lista los contenedores activos:
   ```bash
   docker ps
   ```

2. Copia el CONTAINER ID del contenedor de Jenkins y accede a él:
   ```bash
   docker exec -it <ID_DEL_CONTENEDOR> bash
   ```

3. Visualiza la contraseña de desbloqueo:
   ```bash
   cat /var/jenkins_home/secrets/initialAdminPassword
   ```

4. Copia la contraseña y pégala en el navegador para desbloquear Jenkins.

---

## 4. Configuración dentro de Jenkins

1. Instala los plugins recomendados cuando se te solicite.
2. Crea el usuario administrador (puedes usar cualquier nombre/contraseña).
3. En la sección de configuración, deja todo por defecto y finaliza.

---

## 5. Crear Pipeline de Integración

1. Desde el dashboard de Jenkins, haz clic en "Nueva tarea".
2. Introduce un nombre para la tarea.
3. Selecciona "Pipeline" y haz clic en "OK".
4. En la sección "Definition", elige: Pipeline script from SCM.
5. En SCM, selecciona Git y proporciona esta URL del repositorio:

   https://github.com/VDianez/simple-python-pyinstaller-app.git

6. En Branch Specifier, escribe:
   ```
   */main
   ```

7. Guarda la configuración y luego haz clic en "Construir ahora".

---

## Resultado

Si todo ha sido configurado correctamente, Jenkins descargará el proyecto, ejecutará el pipeline definido en el Jenkinsfile, y verás la ejecución del proceso paso a paso.