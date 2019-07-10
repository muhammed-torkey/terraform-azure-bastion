resource "azurerm_subnet" "bastion-subnet" {
  name                      = "bastion-subnet"
  resource_group_name       = "${data.azurerm_resource_group.openshift.name}"
  address_prefix            = "${var.bastion_subnet_cidr}"
  virtual_network_name      = "${var.openshift_virtual_network_name}"
  network_security_group_id = "${azurerm_network_security_group.bastion-nsg.id}"
}