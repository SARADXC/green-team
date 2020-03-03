    variable subscription_id {
        default = "41fc815a-6da1-44ca-b913-08f3f171e86f"
    } 
    variable  client_id {
        default = "fd6cee40-8606-4a65-8feb-9045ea9118bb"
    }   
    variable  client_secret {
        default = "EB3JzT@Hi/rGgFcbkPUWoD=s[2lrVO69"
    }  
    variable   tenant_id     {
        default = "e4cb0c95-0b68-46b6-98d1-32a52525d82d"
    }  


    ##############################################################################
# Variables File
# 
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "resource_group" {
  description = "The name of your Azure Resource Group."
  default     = "GreenTeamRG1"
}

variable "prefix" {
  description = "This prefix will be included in the name of some resources."
  default     = "gt"
}

variable "hostname" {
  description = "Virtual machine hostname. Used for local hostname, DNS, and storage-related names."
  default     = "Web1"
}

variable "hostname1" {
  description = "Virtual machine hostname. Used for local hostname, DNS, and storage-related names."
  default     = "Web2"
}
variable "hostname2" {
  description = "Virtual machine hostname. Used for local hostname, DNS, and storage-related names."
  default     = "App1"
}
variable "hostname3" {
  description = "Virtual machine hostname. Used for local hostname, DNS, and storage-related names."
  default     = "App2"
}
variable "location" {
  description = "The region where the virtual network is created."
  default     = "eastus"
}

variable "virtual_network_name" {
  description = "The name for your virtual network."
  default     = "vnet"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "storage_account_tier" {
  description = "Defines the storage tier. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Defines the replication type to use for this storage account. Valid options include LRS, GRS etc."
  default     = "LRS"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_B1ms"
}

variable "image_publisher" {
  description = "Name of the publisher of the image (az vm image list)"
  default     = "OpenLogic"
}

variable "image_offer" {
  description = "Name of the offer (az vm image list)"
  default     = "CentOS"
}

variable "image_sku" {
  description = "Image SKU to apply (az vm image list)"
  default     = "7.5:7.5.201808150"
}

variable "image_version" {
  description = "Version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "admin_username" {
  description = "Administrator user name"
  default     = "azureuser"
}

variable "admin_password" {
  description = "Administrator password"
  default     = "greenteam@2020"
}

variable "source_network" {
  description = "Allow access from this network prefix. Defaults to '*'."
  default     = "*"
}