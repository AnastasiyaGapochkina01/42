resource "yandex_vpc_security_group" "http-sg" {
  name       = "http-sg"
  network_id = yandex_vpc_network.autoscaling-net.id
  egress {
    protocol       = "ANY"
    description    = "allow any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    description    = "allow incoming to 80 port"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
  ingress {
    protocol          = "TCP"
    description       = "allow LB healthchecks"
    predefined_target = "loadbalancer_healthchecks"
    port              = 80
  }
}
