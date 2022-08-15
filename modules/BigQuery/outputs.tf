output "dataset_ids" {
  value = google_bigquery_dataset.dataset[*].id
}