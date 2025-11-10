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
  name = "tcp_network"
}

resource "docker_image" "srv1" {
  name = "srv1"
  build {
    context = "${path.module}/srv1"
  }
}

resource "docker_container" "srv1" {
  name  = "srv1"
  image = docker_image.srv1.name
  networks_advanced {
    name = docker_network.net.name
  }
  ports {
    internal = 5000
  }
}

resource "docker_image" "srv2" {
  name = "srv2"
  build {
    context = "${path.module}/srv2"
  }
}

resource "docker_container" "srv2" {
  name  = "srv2"
  image = docker_image.srv2.name
  networks_advanced {
    name = docker_network.net.name
  }
  ports {
    internal = 5000
  }
}

resource "docker_image" "haproxy" {
  name = "haproxy_tcp"
  build {
    context = "${path.module}/haproxy"
  }
}

resource "docker_container" "haproxy" {
  name  = "haproxy_tcp"
  image = docker_image.haproxy.name
  networks_advanced {
    name = docker_network.net.name
  }
  ports {
    internal = 4000
    external = 4000
  }
  depends_on = [docker_container.srv1, docker_container.srv2]
}
