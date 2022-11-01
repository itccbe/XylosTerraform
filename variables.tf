# variable "customer_abbreviation" {
#   default = "itcc"
#   type = string
# }

variable "environment" {
  type = string
}

variable "location" {
  default = "westeurope"
  type    = string
}

variable "resource_group_name" {
  type = string
}
