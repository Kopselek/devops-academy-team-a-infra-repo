resource "azurerm_network_security_group" "main_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  security_rule {
    name                       = "SSH-Rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.environment,
    Author = var.author,
    Time = "${local.now}"
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}:?"
}

resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
  lower   = true
}