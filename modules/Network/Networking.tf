resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.subnet_region
  network       = google_compute_network.vpc.id
  secondary_ip_range {
    range_name    = var.secondary_range_names[0] 
    ip_cidr_range = var.secondary_ranges[0]
  }
  secondary_ip_range {
    range_name    = var.secondary_range_names[1] 
    ip_cidr_range = var.secondary_ranges[1]
  }
  private_ip_google_access = var.private_ip_google_access

  depends_on = [
    google_compute_network.vpc
  ]
}
