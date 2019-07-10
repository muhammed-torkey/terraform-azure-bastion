data "azurerm_resource_group" "openshift" {
  name     = "${var.resource_group_name}"
}