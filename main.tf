terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-b"
  folder_id = "b1gdge57rslfb323otnm"
}

data "yandex_compute_image" "nginx-image" {
  image_id = "fd8n92ptnt76vl1vpqpa"
}
