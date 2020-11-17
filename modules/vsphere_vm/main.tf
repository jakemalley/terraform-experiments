## Module for building a vSphere VM from VMware Template

resource "random_password" "root" {
    length = var.root_password_length
    special = true
}

resource "vsphere_virtual_machine" "vm" {
    name = var.vm_name
    resource_pool_id = data.vsphere_resource_pool.resource_pool.id
    datastore_id = data.vsphere_datastore.datastore.id
    folder = var.folder

    annotation = "VM created using Terraform. (${data.vsphere_virtual_machine.template.annotation})"

    num_cpus = var.num_cpus != null ? var.num_cpus : data.vsphere_virtual_machine.template.num_cpus
    cpu_hot_add_enabled = true
    cpu_hot_remove_enabled = true
    memory   = var.memory != null ? var.memory : data.vsphere_virtual_machine.template.memory
    memory_hot_add_enabled = true

    guest_id = data.vsphere_virtual_machine.template.guest_id

    scsi_type = data.vsphere_virtual_machine.template.scsi_type

    tags = [
        data.vsphere_tag.tag.id
    ]

    network_interface {
        network_id   = data.vsphere_network.network.id
        adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    }

    disk {
        label            = "disk0"
        size             = data.vsphere_virtual_machine.template.disks.0.size
        eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
        thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
    }

    dynamic disk {
        for_each = var.additional_disks
        content {
            label = format("disk%s", disk.key + 1)
            unit_number = disk.key + 1
            size = disk.value
            thin_provisioned = true
        }
    }

    clone {
        template_uuid = data.vsphere_virtual_machine.template.id
        customize {
            linux_options {
                host_name = var.vm_name
                domain    = var.dns_domain
            }

            network_interface {
                ipv4_address = var.network_type == "static" ? var.network_options.ipv4_address : null
                ipv4_netmask = var.network_type == "static" ? var.network_options.ipv4_netmask : null
            }

            ipv4_gateway = var.network_type == "static" ? var.network_options.ipv4_gateway : null
            dns_server_list = var.network_type == "static" ? var.network_options.dns_server_list : null
        }
    }

    provisioner "file" {
        content = templatefile(
            "${path.module}/bootstrap.sh.tpl",
            {
                root_password = random_password.root.result
                user = var.build_user
                password_hash = var.build_password_hash
                user_uid = var.build_uid
                ssh_key = var.build_ssh_key
            }
        )
        destination = "/bootstrap.sh"
        connection {
            type = "ssh"
            host = self.guest_ip_addresses[0]
            user = var.template_username
            password = var.template_password
        }
    }

    provisioner "remote-exec" {
        inline = [
            "bash /bootstrap.sh",
            "rm -f /bootstrap.sh",
            "reboot"
        ]
        on_failure = continue
        connection {
            type = "ssh"
            host = self.guest_ip_addresses[0]
            user = var.template_username
            password = var.template_password
        }
    }
}
