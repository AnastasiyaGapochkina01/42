resource "yandex_lb_network_load_balancer" "web-balancer" {
  name = "web-balancer"

  listener {
    name        = "http"
    port        = 80
    target_port = 80
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.autoscaling-web.load_balancer[0].target_group_id
    healthcheck {
      name = "web-check"
      tcp_options {
        port = 80
      }
    }
  }
}
