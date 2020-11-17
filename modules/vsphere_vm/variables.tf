# Variables for vSphere VM Module

variable "datacenter" {
    description = "Name of the Datacenter"
    type = string
}

variable "datastore" {
    description = "Name of the Datastore"
    type = string
}

variable "resource_pool" {
    description = "Name of the Resource Pool"
    type = string
}

variable "folder" {
    description = "Name of the Folder"
    type = string
}

variable "network" {
    description = "Name of the Network"
    type = string
}

variable "network_type" {
    description = "Networking type, either 'dhcp' or 'static'"
    type = string
    default = "dhcp"

    validation {
        condition = var.network_type == "dhcp" || var.network_type == "static"
        error_message = "Networking type must be either 'dhcp' or 'static'."
    }
}

variable "network_options" {
    description = "Networking Options"
    type = object({
        ipv4_address = string
        ipv4_netmask = number
        ipv4_gateway = string
        dns_server_list = list(string)
    })
    default = null
}

variable "dns_domain" {
    description = "VM's DNS Domain"
    type = string
}

variable "template" {
    description = "Name of the VMware template to clone"
    type = string
}

variable "template_username" {
    description = "SSH User for provisioning"
    type = string
}

variable "template_password" {
    description = "SSH Password for provisioning"
    type = string
}

variable "vm_name" {
    description = "Name of the VM"
    type = string
}

variable "num_cpus" {
    description = "Number of vCPUs"
    type = number
    default = null
}

variable "memory" {
    description = "Amount of memory (MBs)"
    type = number
    default = null
}

variable "additional_disks" {
    description = "Additional Disks"
    type = list(number)
    default = []
}

variable "root_password_length" {
    description = "Length of the random root password"
    type = number
    default = 32
}

variable "build_user" {
    description = "Local Ansible User's Username"
    type = string
}
variable "build_password_hash" {
    description = "Local Ansible User's Password (Hashed)"
    type = string
}
variable "build_uid" {
    description = "Local Ansible User's UID"
    type = number
}
variable "build_ssh_key" {
    description = "Local Ansible User's SSH Key"
    type = string
}
