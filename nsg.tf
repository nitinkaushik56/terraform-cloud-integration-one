resource "azurerm_network_security_group" "web_nsg" {
  name                = "${local.name_prefix}-nsg"
  location            =  azurerm_resource_group.my_rg.location
  resource_group_name =  azurerm_resource_group.my_rg.name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

  locals {
  web_nsg_rule ={ #named
    "110" : "22", #again the name we have expression in key value format priority and port number
    "120" : "80",
    "130" : "443",
    "140" : "3389",
 
  }
}
#lets create the nsg rules using for each loop
resource "azurerm_network_security_rule" "web_nsg_rule" {
  #inside the resource block we will put for each loop to create the rules dynamically
  for_each = local.web_nsg_rule
  name                        = "Rule_port_${each.value}" #Rule_port_22
  priority                    = each.key #110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value #22
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}
