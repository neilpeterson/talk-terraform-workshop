provider "azurerm" {
  version         = "1.29.0"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "hello-world" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "azurerm_container_group" "hello-world" {
  name                = "${var.container-name}"
  location            = "${azurerm_resource_group.hello-world.location}"
  resource_group_name = "${azurerm_resource_group.hello-world.name}"
  ip_address_type     = "public"
  dns_name_label      = "${var.dns-prefix}"
  os_type             = "linux"

  container {
    name   = "hello-world"
    image  = "${var.container-image}"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port      = 80
      protocol  = "TCP"
    }

  }
}