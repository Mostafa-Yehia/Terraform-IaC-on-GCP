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

variable "email" {
  type = string
}

variable "metadata_startup_script" {
  type = string
}