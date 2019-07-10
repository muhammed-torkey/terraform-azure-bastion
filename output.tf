output "bastion_public_dns" {
  value = "${azurerm_public_ip.bastion.fqdn}"
}

output "bastion_ip_address" {
  value = "${azurerm_public_ip.bastion.ip_address}"
}