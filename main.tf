locals {
  now    = timestamp()
  date   = formatdate("D-MM-YYYY hh:mm:ss", local.now)
}

# Create a resource group
resource "azurerm_resource_group" "main_rg" {
  name     = var.rg_name
  location = var.location
  
  tags = {
    Environment = var.environment,
    Author = var.author,
    Time = "${local.now}"
  }
}

resource "azurerm_virtual_network" "main_vn" {
  name                = var.vn_name
  address_space       = var.vn_addrspace
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  depends_on = [
    azurerm_resource_group.main_rg
  ]
}

resource "azurerm_subnet" "main_sn" {
  name                 = var.sn_name
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.main_vn.name
  address_prefixes     = var.sn_addrprfx

  depends_on = [
    azurerm_resource_group.main_rg,
    azurerm_virtual_network.main_vn
  ]
}

resource "null_resource" "invoke_ansible" {
  depends_on = [
    azurerm_linux_virtual_machine.linux_vm
  ]
  provisioner "local-exec" {
    command = "sleep 60 && ansible-playbook ./scripts/ansible/main.yaml -i inventory-linux"
  }
}
