#output "vm_ids" {
#  value = google_compute_instance.machine[*].instance_id
#}

output "vm_ids" {
  description = "Virtual machine IDs"
  value = tomap({
    for k, server in google_compute_instance.machine : k => server.id
  })
}