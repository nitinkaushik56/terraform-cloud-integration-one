##go inside vm.tf delete everything and add this copy from line 55 till 85
 resource "azurerm_linux_virtual_machine" "web_vm" {
    for_each            = var.instance
  name                = "${local.name_prefix}-${each.key}-linuxvm"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  size                = each.value.size
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic[each.key].id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
    #path.module is an meta argument in terraform which will look for your file in current directory where your terraform file is present. In this case it will look for the ssh key in the ssh-keys folder which is present in the same directory as this terraform file.
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app.sh") #this will run the cloud-init script which is present in the cloud-init folder in the same directory as this terraform file.
   tags  = merge(local.project_tags, { "Instance" = each.key })
}

output "vm_details" {
  value = {
    for name, vm in azurerm_linux_virtual_machine.web_vm : name => {
#      public_ip  = azurerm_public_ip.web_public_ip[name].ip_address
      private_ip = azurerm_network_interface.web_nic[name].private_ip_address
      nic_id     = azurerm_network_interface.web_nic[name].id
      vm = vm.size
      vm_id = vm.id
      vm_name = vm.name
    }
  }
}