variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "nitin_rg"
}

variable "location" {
  description = "location of the region"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "nitin-network"
}
variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "web-subnet"
}
variable "subnet_address_prefixes" {
  description = "The address prefixes of the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "sap"
}

variable "environment" {
  description = "The environment of the project"
  type        = string
  default     = "dev"
}

