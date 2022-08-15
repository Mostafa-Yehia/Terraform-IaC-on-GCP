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

variable "service_account" {
  type = string
}
