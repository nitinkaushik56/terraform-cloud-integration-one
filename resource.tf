resource "azurerm_resource_group" "my_rg" {
  name = "${local.name_prefix}-${var.resource_group_name}"
  #sap-dev-gopal-rg
  location = var.location
}