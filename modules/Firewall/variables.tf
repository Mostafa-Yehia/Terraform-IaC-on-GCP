variable "vpc_name" {
  type = string
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