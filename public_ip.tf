resource "azurerm_public_ip" "bastion" {
  name                = "bastion-static"
  location            = "${data.azurerm_resource_group.openshift.location}"
  resource_group_name = "${data.azurerm_resource_group.openshift.name}"
  allocation_method   = "Static"

  domain_name_label   = "${var.platform_name}-bastion"

  tags = "${var.tags}"
}