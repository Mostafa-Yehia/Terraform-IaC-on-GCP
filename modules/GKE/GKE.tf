resource "google_container_cluster" "primary" {
  name                          = var.cluster_name
  location                      = var.cluster_location
  network                       = var.network
  subnetwork                    = var.subnetwork
  ip_allocation_policy {
    cluster_secondary_range_name    = var.cluster_secondary_range_name
    services_secondary_range_name   = var.services_secondary_range_name
  }
  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  } 
  master_authorized_networks_config {
    cidr_blocks {
        cidr_block = var.cidr_blocks[0]
    }
    cidr_blocks {
        cidr_block = var.cidr_blocks[1]
    }
    cidr_blocks {
        cidr_block = var.cidr_blocks[2]
    }
  }
  cluster_autoscaling {
    enabled = var.autoscaling
  }
  remove_default_node_pool      = var.remove_default_node_pool
  initial_node_count            = var.initial_node_count
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name              = var.node_name 
  node_locations    = var.node_locations
  cluster           = google_container_cluster.primary.name
  node_count        = var.node_count

  node_config {
    disk_size_gb    = var.disk_size_gb
    machine_type    = var.machine_type
    image_type      = var.image_type
    service_account = var.service_account
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  
  depends_on = [
    google_container_cluster.primary
  ]
}