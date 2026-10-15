#lets create a file called as instance.tf copy from line 2 till 18
  variable "instance" { #studentdb
  description = "configuration for multiple azure virtual machine"
  type = map(object({
    size = string #name
    zone = string #address 
  }))
  default = {
    "vm1" = {
      size = "Standard_F2"
      zone = "1"
    }
    "vm2" = {
      size = "Standard_B1s"
      zone = "2"
    }
    "vm3" = {
      size = "Standard_B1s"
    zone = "2"   
    }
  }
}