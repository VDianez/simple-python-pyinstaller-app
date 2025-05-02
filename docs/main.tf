provider "docker" {}

# Red para Jenkins y Dind
resource "docker_network" "jenkins_net" {
  name = "jenkins"
}

# Docker in Docker (dind)
resource "docker_container" "dind" {
  name       = "jenkins-docker"
  image      = "docker:dind"
  privileged = true
  restart    = "on-failure"

  networks_advanced {
    name    = docker_network.jenkins_net.name
    aliases = ["docker"]
  }

  env = [
    "DOCKER_TLS_CERTDIR=/certs"
  ]

  volumes {
    host_path      = abspath("${path.cwd}/jenkins-docker-certs")
    container_path = "/certs/client"
  }
  
  ports {
    internal = 2376
    external = 2376
  }
}

# Jenkins usando imagen existente
resource "docker_container" "jenkins" {
  name    = "jenkins-blueocean"
  image   = "jenkinsci/blueocean:latest"
  restart = "on-failure"

  networks_advanced {
    name = docker_network.jenkins_net.name
  }

  env = [
    "DOCKER_HOST=tcp://docker:2376",
    "DOCKER_CERT_PATH=/certs/client",
    "DOCKER_TLS_VERIFY=1"
  ]

  ports {
    internal = 8080
    external = 8080
  }

  ports {
    internal = 50000
    external = 50000
  }

  volumes {
    host_path      = abspath("${path.cwd}/jenkins-home")
    container_path = "/var/jenkins_home"
  }

  volumes {
    host_path      = abspath("${path.cwd}/jenkins-docker-certs")
    container_path = "/certs/client"
    read_only      = true
  }

  # Volumen para acceder a los archivos del proyecto
  volumes {
    host_path      = abspath(path.cwd)
    container_path = "/var/jenkins_home/workspace/proyecto"
    read_only      = true
  }

  depends_on = [
    docker_container.dind
  ]
}