resource "yandex_vpc_network" "autoscaling-net" {
  name = "autoscaling-net"
}

resource "yandex_vpc_subnet" "autoscaling-subnet-a" {
  name           = "autoscaling-subnet-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.1.0/24"]
  network_id     = yandex_vpc_network.autoscaling-net.id
}

resource "yandex_vpc_subnet" "autoscaling-subnet-b" {
  name           = "autoscaling-subnet-b"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["192.168.2.0/24"]
  network_id     = yandex_vpc_network.autoscaling-net.id
}
