resource "google_service_account" "service_account" {
  count        = length(var.service_account_names)

  account_id   = "${var.service_account_id}-${var.service_account_names[count.index]}"
  display_name = "${var.service_account_name}-${var.service_account_names[count.index]}"
}

resource "google_service_account_key" "json_key_generator" {
  count                = length(var.service_account_names)

  service_account_id   = "${var.service_account_name}-${var.service_account_names[count.index]}"

  depends_on = [
    google_service_account.service_account
  ]
}