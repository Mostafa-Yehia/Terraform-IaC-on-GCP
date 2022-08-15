output "buckets_url" {
  value = google_container_registry.registry[*].id
}