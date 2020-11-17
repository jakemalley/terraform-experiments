# Data for vSphere VM Module

data "vsphere_datacenter" "datacenter" {
    name = var.datacenter
}

data "vsphere_datastore" "datastore" {
    name = var.datastore
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "resource_pool" {
    name = var.resource_pool
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
    name = var.network
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
    name = var.template
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_tag_category" "tag_category" {
    name = "terraform"
}

data "vsphere_tag" "tag" {
    name = "terraform-managed"
    category_id = data.vsphere_tag_category.tag_category.id
}
