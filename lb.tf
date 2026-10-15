#lets create a new file lb.tf copy line 2 till 33 then do terraform apply
  resource "azurerm_public_ip" "lb_public_ip" {

  name                = "${local.name_prefix}-lb-public-ip"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  allocation_method   = "Static"
  sku                 = "Standard" #publicip ip will be spread across regions and will be highly available across zones
  
  
}
output "lb_public_ip" {
  value = azurerm_public_ip.lb_public_ip.ip_address
}
#lb
resource "azurerm_lb" "web_lb" {
  name                = "${local.name_prefix}-lb"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}
#backend pool
resource "azurerm_lb_backend_address_pool" "weblb_backend_pool" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name                = "${local.name_prefix}-lb-backend-pool"
}
#probes
#lb rules
#attach those nic card with the backend pool
resource "azurerm_lb_probe" "weblb_probe" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name                = "${local.name_prefix}-lb-probe"
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 30 #every 30 second it will ping your vm on port 80 
  number_of_probes    = 2 #two times it will ping 1 min if it dont get response it will mark the vm as unhealthy and will not send traffic to that vm
}
#lb rules
resource "azurerm_lb_rule" "weblb_rule" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name                = "${local.name_prefix}-lb-rule"
  protocol            = "Tcp"
  frontend_port       = 80 #lb port
  backend_port        = 80 #vm port if inside my vm i am running a tomcat server
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.weblb_backend_pool.id]
  probe_id                       = azurerm_lb_probe.weblb_probe.id
}
#attach those nic card with the backend pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool_association" {
  for_each            = var.instance
  network_interface_id    = azurerm_network_interface.web_nic[each.key].id
  ip_configuration_name   = azurerm_network_interface.web_nic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.weblb_backend_pool.id
}