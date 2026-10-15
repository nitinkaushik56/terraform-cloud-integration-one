#lets modify the nic.tf file delete everything copy from line 34 till 49
  resource "azurerm_network_interface" "web_nic" {
    for_each            = var.instance

  name                = "${local.name_prefix}-${each.key}-nic"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location


  ip_configuration { #this nic card will get an public and private ip
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
#    public_ip_address_id          = azurerm_public_ip.web_public_ip[each.key].id
  }
   tags  = merge(local.project_tags, { "Instance" = each.key })
}