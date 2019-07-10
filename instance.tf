resource "azurerm_network_interface" "bastion-instance" {
  name                      = "bastion-instance-interface"
  location                  = "${data.azurerm_resource_group.openshift.location}"
  resource_group_name       = "${data.azurerm_resource_group.openshift.name}"
  network_security_group_id = "${azurerm_network_security_group.bastion-nsg.id}"

  ip_configuration {
    name                          = "bastion-subnet"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "${azurerm_subnet.bastion-subnet.id}"

    public_ip_address_id = "${azurerm_public_ip.bastion.id}"
  }
}

resource "azurerm_virtual_machine" "bastion-instance" {
  name                = "bastion"
  location            = "${data.azurerm_resource_group.openshift.location}"
  resource_group_name = "${data.azurerm_resource_group.openshift.name}"

  vm_size               = "${var.bastion_shape}"
  network_interface_ids = ["${azurerm_network_interface.bastion-instance.id}"]
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.4"
    version   = "latest"
  }

  os_profile {
    computer_name  = "bastion"
    admin_username = "${var.admin_username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = "${file(var.public_key_path)}"
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
    }
  }

  storage_os_disk {
    name              = "bastion-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  tags = "${merge(var.tags, map("Name", "${var.platform_name}-bastion"))}"
}
