resource "google_bigquery_dataset" "dataset" {
  count                       = var.dataset_number

  dataset_id                  = "${var.dataset_id}_${count.index + 1}"
  location                    = var.dataset_location
}

resource "google_bigquery_dataset_iam_member" "editor" {
  count                       = var.dataset_number

  dataset_id = "${var.dataset_id}_${count.index + 1}"
  role       = var.dataset_role
  member     = var.dataset_member

  depends_on = [
    google_bigquery_dataset.dataset
  ]
}