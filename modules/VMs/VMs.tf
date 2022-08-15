resource "google_compute_instance" "machine" {

#count        = var.vms ? length(var.vms) : 0

  for_each     = {for v in var.vms : v.name => v}
  name         = "${each.value.name}"
  machine_type = each.value.machine_type
  zone         = each.value.zone
  tags         = each.value.tags
  boot_disk {
    initialize_params {
      image = each.value.image
    }
  }
  network_interface {
    network     = each.value.network
    subnetwork  = each.value.subnet
    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = var.metadata_startup_script

  service_account {
    email  = var.email
    scopes = ["cloud-platform"]
  }
}