# Basic Variables
variable "location" {
    description = "This variable is responsible for Azure region"
    default = "West Europe"
}

variable "linvmnumber" {
    description = "This variable is responsible for number of linux VMs that will be created"
    default = "1"
}

variable "size" {
    description = "This variable is responsible for parameters of specific VM such as RAM, proc etc."
    default = "Standard_F2"
}

variable "rg_name" {
    description = "Resource group name."
    default = "Tieto-Project"
}

variable "vn_name" {
    description = "Virtual network name/"
    default = "environment_net"
}

variable "vn_addrspace" {
    description = "Virtual network address space."
    default = ["10.0.0.0/16"]
}

variable "sn_name" {
    description = "Subnet name."
    default = "internal"
}

variable "sn_addrprfx" {
    description = "Subnet address prefixes."
    default = ["10.0.2.0/24"]
}

variable "nsg_name" {
    description = "Network security group name for windows machines."
    default = "env-nsg"
}

# Linux VMS
variable "lin_publisher" {
    description = "Publisher value"
    default = "Canonical"
}

variable "lin_offer" {
    description = "Offer value"
    default = "0001-com-ubuntu-server-jammy"
}

variable "lin_sku" {
    description = "Sku value"
    default = "22_04-lts"
}

variable "lin_version" {
    description = "Version value"
    default = "latest"
}

variable "lin_usrname" {
    description = "Linux vm user name."
    default = "tietoprojectadmin"
}

variable "computer_name" {
    description = "Linux vm computer name."
    default = "linvm"
}

# Tags Informations
variable "environment" {
    description = "Use it in tags to describe type of environment, for example production, testing, development etc."
    default = "development"
}

variable "author" {
    description = "Use it in tags for the name of the creator of the deployment."
    default = "Jantro"
}