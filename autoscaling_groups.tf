resource "yandex_compute_instance_group" "autoscaling-web" {
  name               = "autoscaling-web"
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.sa-autoscaling.id

  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.nginx-image.id
        size     = 20
      }
    }
    network_interface {
      network_id = yandex_vpc_network.autoscaling-net.id
      subnet_ids = [
        yandex_vpc_subnet.autoscaling-subnet-a.id,
        yandex_vpc_subnet.autoscaling-subnet-b.id
      ]
      security_group_ids = [yandex_vpc_security_group.http-sg.id]
      nat                = true
    }
  }

  scale_policy {
    auto_scale {
      initial_size           = 2
      cpu_utilization_target = 40
      min_zone_size          = 1
      max_size               = 6
      measurement_duration = 60
    }
  }

  allocation_policy {
    zones = [
      "ru-central1-a",
      "ru-central1-b"
    ]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name        = "web-autoscale-tg"
    target_group_description = "web target group"
  }
}
