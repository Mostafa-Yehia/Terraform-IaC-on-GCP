resource "google_container_registry" "registry" {
  location = var.gcr_location
}

resource "google_storage_bucket_iam_member" "viewer" {
  bucket    = google_container_registry.registry.id
  role      = var.gcr_role
  member    = var.gcr_member

  depends_on = [
    google_container_registry.registry
  ]
}