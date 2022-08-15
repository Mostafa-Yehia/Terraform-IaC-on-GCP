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