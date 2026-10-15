output "resource_group_name" {
  description = "The name of the resource group"
  #where is the resource group information are stored inside the state file
  value = azurerm_resource_group.my_rg.name
}

output "location" {
  description = "The name of the resource group location"
  #where is the resource group information are stored inside the state file
  value = azurerm_resource_group.my_rg.location
}

output "vnet_name" {
  description = "name of the virtual network"
  #this will tell name of my vnet
  value = azurerm_virtual_network.vnet.name
}