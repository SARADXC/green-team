provider "azurerm" {
    version = "1.44.0"


    subscription_id = "var.subscription_id"
    client_id = "var.client_id"
    client_secret = "var.client_secret"
    tenant_id = "var.tenant_id"
}


##############################################################################
# * HashiCorp Beginner's Guide to Using Terraform on Azure
# 
# This Terraform configuration will create the following:
#
# Resource group with a virtual network and subnet
# 4 CentOS Linux servers 
##############################################################################
# * Shared infrastructure resources

# First we'll create a resource group. In Azure every resource belongs to a 
# resource group. Think of it as a container to hold all your resources. 
# You can find a complete list of Azure resources supported by Terraform here:
# https://www.terraform.io/docs/providers/azurerm/
resource "azurerm_resource_group" "GreenTeamRG1" {
  name     = "var.resource_group"
  location = "var.location"
}

# The next resource is a Virtual Network. We can dynamically place it into the
# resource group without knowing its name ahead of time. Terraform handles all
# of that for you, so everything is named consistently every time. Say goodbye
# to weirdly-named mystery resources in your Azure Portal. To see how all this
# works visually, run `terraform graph` and copy the output into the online
# GraphViz tool: http://www.webgraphviz.com/
resource "azurerm_virtual_network" "vnet" {
  name                = "var.virtual_network_name"
  location            = "azurerm_resource_group.GreenTeamRG1.location"
  address_space       = ["var.address_space"]
  resource_group_name = "azurerm_resource_group.GreenTeamRG1.name"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "var.virtual_network_name1"
  location            = "azurerm_resource_group.GreenTeamRG1.location"
  address_space       = ["var.address_space"]
  resource_group_name = "azurerm_resource_group.GreenTeamRG1.name"
}
resource "azurerm_virtual_network" "vnet2" {
  name                = "var.virtual_network_name2"
  location            = "azurerm_resource_group.GreenTeamRG1.location"
  address_space       = ["var.address_space"]
  resource_group_name = "azurerm_resource_group.GreenTeamRG1.name"
}
resource "azurerm_virtual_network" "vnet3" {
  name                = "var.virtual_network_name3"
  location            = "azurerm_resource_group.GreenTeamRG1.location"
  address_space       = ["var.address_space"]
  resource_group_name = "azurerm_resource_group.GreenTeamRG1.name"
}
# Next we'll build a subnet to run our VMs in. These variables can be defined 
# via environment variables, a config file, or command line flags. Default 
# values will be used if the user does not override them. You can find all the
# default variables in the variables.tf file. You can customize this demo by
# making a copy of the terraform.tfvars.example file.
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}subnet"
  virtual_network_name = "azurerm_virtual_network.vnet.name"
  resource_group_name  = "azurerm_resource_group.GreenTeamRG1.name"
  address_prefix       = "var.subnet_prefix"
}

##############################################################################
# * Build CentOS Linux VM
#
# Now that we have a network, we'll deploy an CentOS Linux VM Linux server.
# An Azure Virtual Machine has several components. In this example we'll build
# a security group, a network interface, a public ip address, a storage 
# account and finally the VM itself. Terraform handles all the dependencies 
# automatically, and each resource is named with user-defined variables.

# Security group to allow inbound access on port 80 (http) and 22 (ssh)
resource "azurerm_network_security_group" "greenteam-sg" {
  name                = "var.prefix-sg"
  location            = "var.location"
  resource_group_name = "azurerm_resource_group.GreenTeamRG1.name"

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "var.source_network"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "var.source_network"
    destination_address_prefix = "*"
  }
}

# A network interface. This is required by the azurerm_virtual_machine 
# resource. Terraform will let you know if you're missing a dependency.
resource "azurerm_network_interface" "GreenTeam-nic" {
  name                      = "${var.prefix}GreenTeam-nic"
  location                  = "var.location"
  resource_group_name       = "azurerm_resource_group.GreenTeamRG1.name"
  network_security_group_id = "${azurerm_network_security_group.greenteam-sg}"

  ip_configuration {
    name                          = "${var.prefix}ipconfig"
    subnet_id                     = "azurerm_subnet.subnet.id"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "azurerm_public_ip.GreenTeam-pip.id"
  }
}

resource "azurerm_network_interface" "GreenTeam-nic1" {
  name                      = "${var.prefix}GreenTeam-nic1"
  location                  = "var.location"
  resource_group_name       = "azurerm_resource_group.GreenTeamRG1.name"
  network_security_group_id = "${azurerm_network_security_group.greenteam-sg}"

  ip_configuration {
    name                          = "${var.prefix}ipconfig"
    subnet_id                     = "azurerm_subnet.subnet.id"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "azurerm_public_ip.GreenTeam-pip.id"
  }
}
resource "azurerm_network_interface" "GreenTeam-nic2" {
  name                      = "${var.prefix}GreenTeam-nic2"
  location                  = "var.location"
  resource_group_name       = "azurerm_resource_group.GreenTeamRG1.name"
  network_security_group_id = "${azurerm_network_security_group.greenteam-sg}"

  ip_configuration {
    name                          = "${var.prefix}ipconfig"
    subnet_id                     = "azurerm_subnet.subnet.id"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "azurerm_public_ip.GreenTeam-pip.id"
  }
}
resource "azurerm_network_interface" "GreenTeam-nic3" {
  name                      = "${var.prefix}GreenTeam-nic3"
  location                  = "var.location"
  resource_group_name       = "azurerm_resource_group.GreenTeamRG1.name"
  network_security_group_id = "${azurerm_network_security_group.greenteam-sg}"

  ip_configuration {
    name                          = "${var.prefix}ipconfig"
    subnet_id                     = "azurerm_subnet.subnet.id"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "azurerm_public_ip.GreenTeam-pip.id"
  }
}

# Every Azure Virtual Machine comes with a private IP address. You can also 
# optionally add a public IP address for Internet-facing applications and 
# demo environments like this one.
resource "azurerm_public_ip" "GreenTeam-pip" {
  name                         = "${var.prefix}-ip"
  location                     = "var.location"
  resource_group_name          = "azurerm_resource_group.GreenTeamRG1.name"
#   public_ip_address_allocation = "Dynamic"
  allocation_method = "Dynamic"
  #domain_name_label            = "var.hostname"
}

resource "azurerm_public_ip" "GreenTeam-pip1" {
  name                         = "${var.prefix}-ip1"
  location                     = "var.location"
  resource_group_name          = "azurerm_resource_group.GreenTeamRG1.name"
#   public_ip_address_allocation = "Dynamic"
  allocation_method = "Dynamic"
  #domain_name_label            = "var.hostname"
}
resource "azurerm_public_ip" "GreenTeam-pip2" {
  name                         = "${var.prefix}-ip2"
  location                     = "var.location"
  resource_group_name          = "azurerm_resource_group.GreenTeamRG1.name"
#   public_ip_address_allocation = "Dynamic"
  allocation_method = "Dynamic"
  #domain_name_label            = "var.hostname"
}
resource "azurerm_public_ip" "GreenTeam-pip3" {
  name                         = "${var.prefix}-ip3"
  location                     = "var.location"
  resource_group_name          = "azurerm_resource_group.GreenTeamRG1.name"
#   public_ip_address_allocation = "Dynamic"
  allocation_method = "Dynamic"
  #domain_name_label            = "var.hostname"
}

# And finally we build our virtual machine. This is a standard CentOS Linux VM instance.
# We use the shell provisioner to run a Bash script that configures Apache for 
# the demo environment. Terraform supports several different types of 
# provisioners including Bash, Powershell and Chef.
resource "azurerm_virtual_machine" "site" {
  name                = "var.hostname-site"
  location            = "var.location"
  resource_group_name = "azurerm_resource_group.GreenTeamRG1.name"
  vm_size             = "var.vm_size"

  network_interface_ids         = ["azurerm_network_interface.GreenTeam-nic.id"]
  delete_os_disk_on_termination = "true"

  storage_image_reference {
    publisher = "var.image_publisher"
    offer     = "var.image_offer"
    sku       = "var.image_sku"
    version   = "var.image_version"
  }

  storage_os_disk {
    name              = "${var.hostname}-osdisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "var.hostname"
    admin_username = "var.admin_username"
    admin_password = "var.admin_password"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  # It's easy to transfer files or templates using Terraform.
#   provisioner "file" {
#     source      = "files/setup.sh"
#     destination = "/home/${var.admin_username}/setup.sh"

#     connection {
#       type     = "ssh"
#       user     = "${var.admin_username}"
#       password = "${var.admin_password}"
#       host     = "${azurerm_public_ip.GreenTeam-pip.fqdn}"
#     }
#   }

  # This shell script starts our Apache server and prepares the demo environment.
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /home/${var.admin_username}/setup.sh",
#       "sudo /home/${var.admin_username}/setup.sh",
#     ]

#     connection {
#       type     = "ssh"
#       user     = "${var.admin_username}"
#       password = "${var.admin_password}"
#       host     = "${azurerm_public_ip.GreenTeam-pip.fqdn}"
#     }
#   }


}

resource "azurerm_virtual_machine" "site1" {
  name                = "var.hostname-site1"
  location            = "var.location"
  resource_group_name = "azurerm_resource_group.GreenTeamRG1.name"
  vm_size             = "var.vm_size"

  network_interface_ids         = ["azurerm_network_interface.GreenTeam-nic1.id"]
  delete_os_disk_on_termination = "true"

  storage_image_reference {
    publisher = "var.image_publisher"
    offer     = "var.image_offer"
    sku       = "var.image_sku"
    version   = "var.image_version"
  }

  storage_os_disk {
    name              = "${var.hostname1}-osdisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "var.hostname1"
    admin_username = "var.admin_username"
    admin_password = "var.admin_password"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  # It's easy to transfer files or templates using Terraform.
#   provisioner "file" {
#     source      = "files/setup.sh"
#     destination = "/home/${var.admin_username}/setup.sh"

#     connection {
#       type     = "ssh"
#       user     = "${var.admin_username}"
#       password = "${var.admin_password}"
#       host     = "${azurerm_public_ip.GreenTeam-pip.fqdn}"
#     }
#   }

  # This shell script starts our Apache server and prepares the demo environment.
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /home/${var.admin_username}/setup.sh",
#       "sudo /home/${var.admin_username}/setup.sh",
#     ]

#     connection {
#       type     = "ssh"
#       user     = "${var.admin_username}"
#       password = "${var.admin_password}"
#       host     = "${azurerm_public_ip.GreenTeam-pip.fqdn}"
#     }
#   }


}
resource "azurerm_virtual_machine" "site2" {
  name                = "var.hostname-site2"
  location            = "var.location"
  resource_group_name = "azurerm_resource_group.GreenTeamRG1.name"
  vm_size             = "var.vm_size"

  network_interface_ids         = ["azurerm_network_interface.GreenTeam-nic2.id"]
  delete_os_disk_on_termination = "true"

  storage_image_reference {
    publisher = "var.image_publisher"
    offer     = "var.image_offer"
    sku       = "var.image_sku"
    version   = "var.image_version"
  }

  storage_os_disk {
    name              = "${var.hostname2}-osdisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "var.hostname2"
    admin_username = "var.admin_username"
    admin_password = "var.admin_password"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  # It's easy to transfer files or templates using Terraform.
#   provisioner "file" {
#     source      = "files/setup.sh"
#     destination = "/home/${var.admin_username}/setup.sh"

#     connection {
#       type     = "ssh"
#       user     = "${var.admin_username}"
#       password = "${var.admin_password}"
#       host     = "${azurerm_public_ip.GreenTeam-pip.fqdn}"
#     }
#   }

  # This shell script starts our Apache server and prepares the demo environment.
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /home/${var.admin_username}/setup.sh",
#       "sudo /home/${var.admin_username}/setup.sh",
#     ]

#     connection {
#       type     = "ssh"
#       user     = "${var.admin_username}"
#       password = "${var.admin_password}"
#       host     = "${azurerm_public_ip.GreenTeam-pip.fqdn}"
#     }
#   }


}
resource "azurerm_virtual_machine" "site3" {
  name                = "var.hostname-site3"
  location            = "var.location"
  resource_group_name = "azurerm_resource_group.GreenTeamRG1.name"
  vm_size             = "var.vm_size"

  network_interface_ids         = ["azurerm_network_interface.GreenTeam-nic3.id"]
  delete_os_disk_on_termination = "true"

  storage_image_reference {
    publisher = "var.image_publisher"
    offer     = "var.image_offer"
    sku       = "var.image_sku"
    version   = "var.image_version"
  }

  storage_os_disk {
    name              = "${var.hostname3}-osdisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "var.hostname3"
    admin_username = "var.admin_username"
    admin_password = "var.admin_password"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  # It's easy to transfer files or templates using Terraform.
#   provisioner "file" {
#     source      = "files/setup.sh"
#     destination = "/home/${var.admin_username}/setup.sh"

#     connection {
#       type     = "ssh"
#       user     = "${var.admin_username}"
#       password = "${var.admin_password}"
#       host     = "${azurerm_public_ip.GreenTeam-pip.fqdn}"
#     }
#   }

  # This shell script starts our Apache server and prepares the demo environment.
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /home/${var.admin_username}/setup.sh",
#       "sudo /home/${var.admin_username}/setup.sh",
#     ]

#     connection {
#       type     = "ssh"
#       user     = "${var.admin_username}"
#       password = "${var.admin_password}"
#       host     = "${azurerm_public_ip.GreenTeam-pip.fqdn}"
#     }
#   }


}

##############################################################################
# * Azure MySQL Database

# Terraform can build any type of infrastructure, not just virtual machines. 
# Azure offers managed MySQL database servers and a whole host of other 
# resources. Each resource is documented with all the available settings:
# https://www.terraform.io/docs/providers/azurerm/r/mysql_server.html

# Uncomment the code below to add a MySQL server to your resource group.

# resource "azurerm_mysql_server" "mysql" {
#   name                = "${var.mysql_hostname}"
#   location            = "${azurerm_resource_group.GreenTeamRG1.location}"
#   resource_group_name = "${azurerm_resource_group.GreenTeamRG1.name}"
#   ssl_enforcement     = "Disabled"

#   sku {
#     name     = "MYSQLB50"
#     capacity = 50
#     tier     = "Basic"
#   }

#   administrator_login          = "mysqladmin"
#   administrator_login_password = "Everything-is-bananas-010101"
#   version                      = "5.7"
#   storage_mb                   = "51200"
#   ssl_enforcement              = "Disabled"
# }

# # This is a sample database that we'll populate with the MySQL sample data
# # set provided here: https://github.com/datacharmer/test_db. With Terraform,
# # everything is Infrastructure as Code. No more manual steps, aging runbooks,
# # tribal knowledge or outdated wiki instructions. Terraform is your executable
# # documentation, and it will build infrastructure correctly every time.
# resource "azurerm_mysql_database" "employees" {
#   name                = "employees"
#   resource_group_name = "${azurerm_resource_group.GreenTeamRG1.name}"
#   server_name         = "${azurerm_mysql_server.mysql.name}"
#   charset             = "utf8"
#   collation           = "utf8_unicode_ci"
# }

# # This firewall rule allows database connections from anywhere and is suited
# # for demo environments. Don't do this in production. 
# resource "azurerm_mysql_firewall_rule" "demo" {
#   name                = "GreenTeam-demo"
#   resource_group_name = "${azurerm_resource_group.GreenTeamRG1.name}"
#   server_name         = "${azurerm_mysql_server.mysql.name}"
#   start_ip_address    = "0.0.0.0"
#   end_ip_address      = "0.0.0.0"
# }
