resource "azurerm_network_security_group" "bastion-nsg" {
  name                = "bastion-nsg"
  location            = "${data.azurerm_resource_group.openshift.location}"
  resource_group_name = "${data.azurerm_resource_group.openshift.name}"

  tags = "${var.tags}"

  security_rule {
    name                       = "ssh"
    priority                   = "500"
    access                     = "Allow"
    direction                  = "Inbound"
    protocol                   = "Tcp"
    destination_port_ranges    = ["22"]
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "SSH access from Internet"
  }
}