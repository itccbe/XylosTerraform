variable "location" {
  default = "westeurope"
}

variable "environment" {
  description = "OAuth secret"
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "lawid" {
  type = string
}