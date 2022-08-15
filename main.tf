module "network" {
  source                     = "./modules/Network"
  vpc_name                   = var.vpc_name
  subnet_name                = var.subnet_name
  subnet_cidr                = var.subnet_cidr
  subnet_region              = var.subnet_region
  secondary_range_names      = var.secondary_range_names
  secondary_ranges           = var.secondary_ranges
  private_ip_google_access   = var.private_ip_google_access
}


module "serviceaccount" {
  source                = "./modules/ServiceAccounts"
  service_account_name  = var.service_account_name
  service_account_id    = var.service_account_id
  service_account_names = var.service_account_names

  depends_on = [
      module.network
  ]
}


module "keyhandler" {
  source                         = "./modules/KeyHandler"
  service_account_private_keys   = module.serviceaccount.service_account_private_keys
  service_account_names          = var.service_account_names
  init_bucket_name               = var.init_bucket_name
  bucket_class                   = var.bucket_class
  bucket_location                = var.bucket_location
  bucket_member                  = "${var.bucket_member}:${values(module.serviceaccount.service_accounts_map)[0]}"
  bucket_role                    = var.bucket_role
  
  depends_on = [
      module.serviceaccount
  ]
}


module "buckets" {
  source                    = "./modules/CloudStorage"
  bucket_number             = var.bucket_number
  bucket_name               = var.bucket_name
  bucket_location           = var.bucket_location
  bucket_class              = var.bucket_class
  bucket_member             = "${var.bucket_member}:${values(module.serviceaccount.service_accounts_map)[0]}"
  bucket_role               = var.bucket_role

  depends_on = [
      module.keyhandler
  ]
}


module "bigquery" {
  source                    = "./modules/BigQuery"
  dataset_number            = var.dataset_number
  dataset_id                = var.dataset_id
  dataset_location          = var.dataset_location
  dataset_member            = "${var.bucket_member}:${values(module.serviceaccount.service_accounts_map)[1]}"
  dataset_role              = var.dataset_role

  depends_on = [
      module.keyhandler
  ]
}


module "gcr" {
  source                    = "./modules/GCR"
  gcr_location              = var.gcr_location
  gcr_member                = "${var.bucket_member}:${values(module.serviceaccount.service_accounts_map)[2]}"
  gcr_role                  = var.gcr_role

  depends_on = [
      module.keyhandler
  ]
}



module "vms" {
  source                = "./modules/VMs"
  vms                     = var.vms
  email                   = values(module.serviceaccount.service_accounts_map)[0]
  metadata_startup_script = "#!/bin/bash \nmkdir -p ~/credentials \ngsutil cp -r gs://${var.init_bucket_name} ~/credentials"

  depends_on = [
      module.keyhandler
  ]
}

module "firewall" {
  source       = "./modules/Firewall"
  vpc_name = var.vpc_name
  rules = var.rules

  depends_on = [
    module.network
  ]
}


module "gke" {
  source                           = "./modules/GKE"
  cluster_name                     = var.cluster_name
  cluster_location                 = var.cluster_location
  network                          = var.network
  subnetwork                       = var.subnetwork
  cluster_secondary_range_name     = var.cluster_secondary_range_name
  services_secondary_range_name    = var.services_secondary_range_name
  enable_private_endpoint          = var.enable_private_endpoint
  enable_private_nodes             = var.enable_private_nodes
  master_ipv4_cidr_block           = var.master_ipv4_cidr_block
  cidr_blocks                      = var.cidr_blocks
  autoscaling                      = var.autoscaling
  remove_default_node_pool         = var.remove_default_node_pool
  initial_node_count               = var.initial_node_count
  
  node_name                        = var.node_name
  node_locations                   = var.node_locations
  cluster                          = var.cluster
  node_count                       = var.node_count
  disk_size_gb                     = var.disk_size_gb
  machine_type                     = var.machine_type
  image_type                       = var.image_type
  service_account                  = values(module.serviceaccount.service_accounts_map)[2]
  
  depends_on = [
      module.keyhandler
  ]
}
