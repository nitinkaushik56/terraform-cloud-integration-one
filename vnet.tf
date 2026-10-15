resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name_prefix}-${var.vnet_name}"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  address_space       = var.vnet_address_space
}