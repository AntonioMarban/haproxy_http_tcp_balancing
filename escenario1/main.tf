terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "net" {
  name = "http_network"
}

resource "docker_image" "app1" {
  name = "app1"
  build {
    context = "${path.module}/app1"
  }
}

resource "docker_container" "app1" {
  name  = "app1"
  image = docker_image.app1.name
  networks_advanced {
    name = docker_network.net.name
  }
  ports {
    internal = 8080
  }
}

resource "docker_image" "app2" {
  name = "app2"
  build {
    context = "${path.module}/app2"
  }
}

resource "docker_container" "app2" {
  name  = "app2"
  image = docker_image.app2.name
  networks_advanced {
    name = docker_network.net.name
  }
  ports {
    internal = 8080
  }
}

resource "docker_image" "haproxy" {
  name = "haproxy_http"
  build {
    context = "${path.module}/haproxy"
  }
}

resource "docker_container" "haproxy" {
  name  = "haproxy_http"
  image = docker_image.haproxy.name
  networks_advanced {
    name = docker_network.net.name
  }
  ports {
    internal = 80
    external = 80
  }
  depends_on = [docker_container.app1, docker_container.app2]
}
