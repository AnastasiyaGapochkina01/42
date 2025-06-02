resource "yandex_iam_service_account" "sa-autoscaling" {
  name = "sa-autoscaling"
}

resource "yandex_resourcemanager_folder_iam_member" "autoscaling-role" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-autoscaling.id}"
}
