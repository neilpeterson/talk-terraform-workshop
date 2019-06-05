output "ip_address" {
  value = "${azurerm_container_group.hello-world.ip_address}"
}

output "fqdn" {
  value = "${azurerm_container_group.hello-world.fqdn}"
}