terraform {
  backend "azurerm" {
  resource_group_name  = "nitin-storage-account" #replace this with your storage account resource group name
  storage_account_name = "nitinstorageaccount56" #replace this with your storage account name
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
}
}