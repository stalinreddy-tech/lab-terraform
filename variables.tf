variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resource group"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags applied to the resource group"
  type        = map(string)
  default     = {}
}

variable "virtual_network_name" {
  description = "Name of the Azure virtual network"
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space for the Azure virtual network"
  type        = list(string)
}
