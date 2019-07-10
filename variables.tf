variable "resource_group_name" {
  description = "Your desired azure resource group name"
  type        = "string"
}

variable "platform_name" {
  description = "The name of the cluster that is used for tagging some resources"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = "map"
}

variable "bastion_shape" {}

variable "admin_username" {}

variable "public_key_path" {}

variable "bastion_subnet_cidr" {
  description = ""
  type        = "string"
}

variable "openshift_virtual_network_name" {
  description = ""
  type        = "string"
}