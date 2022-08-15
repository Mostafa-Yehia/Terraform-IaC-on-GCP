#variable "backend_bucket_name" {
#  type = string
#}

variable "project_id" {
  type = string
}

variable "project_region" {
  type = string
}

variable "project_zone" {
  type = string
}

variable "service_account_name" {
  type = string
}

variable "service_account_id" {
  type = string
}

variable "service_account_names" {
  type = list
}

variable "vpc_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "subnet_region" {
  type = string
}

variable "secondary_range_names" {
  type = list
}

variable "secondary_ranges" {
  type = list
}

variable "private_ip_google_access" {
  type = bool
}

variable "init_bucket_name" {
  type = string
}

variable "bucket_number" {
  type = number
}

variable "bucket_name" {
  type = string
}

variable "bucket_location" {
  type = string
}

variable "bucket_class" {
  type = string
}

variable "bucket_member" {
  type = string
}

variable "bucket_role" {
  type = string
}

variable "dataset_number" {
  type = number
}

variable "dataset_id" {
  type = string
}

variable "dataset_location" {
  type = string
}

variable "dataset_member" {
  type = string
}

variable "dataset_role" {
  type = string
}

variable "gcr_location" {
  type = string
}

variable "gcr_member" {
  type = string
}

variable "gcr_role" {
  type = string
}


variable "vms" {
  description = "List of custom vms definition"
  default     = []
  type = list(object({
    name                    = string
    machine_type            = string
    zone                    = string
    network                 = string
    subnet                  = string
    image                   = string
    tags                    = list(string)
  }))
}


variable "rules" {
  description = "List of custom rule definitions (refer to variables file for syntax)."
  default     = []
  type = list(object({
    name                    = string
    description             = string
    direction               = string
    priority                = number
    ranges                  = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
  }))
}



variable "cluster_name" {
  type = string
}

variable "cluster_location" {
  type = string
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "cluster_secondary_range_name" {
  type = string
}

variable "services_secondary_range_name" {
  type = string
}

variable "enable_private_endpoint" {
  type = bool
}

variable "enable_private_nodes" {
  type = bool
}

variable "master_ipv4_cidr_block" {
  type = string
}

variable "cidr_blocks" {
  type = list
}

variable "autoscaling" {
  type = bool
}

variable "remove_default_node_pool" {
  type = bool
}

variable "initial_node_count" {
  type = number
}



variable "node_name" {
  type = string
}

variable "node_locations" {
  type = list
}

variable "cluster" {
  type = string
}

variable "node_count" {
  type = number
}

variable "disk_size_gb" {
  type = number
}

variable "machine_type" {
  type = string
}

variable "image_type" {
  type = string
}