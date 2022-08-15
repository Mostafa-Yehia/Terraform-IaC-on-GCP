variable "service_account_private_keys" {
  type = map
}

variable "service_account_names" {
  type = list
}

variable "init_bucket_name" {
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