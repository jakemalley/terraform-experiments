module "vault" {
    source = "../modules/ansible_vault"

    vault_file = "../vault/example_vault.yml"
    password_file = "../vault/example_vault_password"
}

module "vsphere_vm" {
    source = "../modules/vsphere_vm"

    for_each = {
        for vm in var.lab: vm.vm_name => vm
    }

    vm_name = each.key

    datacenter = each.value.datacenter
    datastore = each.value.datastore
    resource_pool = each.value.resource_pool
    folder = each.value.folder
    network = each.value.network
    network_type = each.value.network_type
    network_options = each.value.network_options
    dns_domain = each.value.dns_domain
    template = each.value.template


    num_cpus = each.value.num_cpus
    memory = each.value.memory
    additional_disks = each.value.additional_disks

    template_username = module.vault.data.packer_template_credentials.username
    template_password = module.vault.data.packer_template_credentials.password

    build_user = module.vault.data.build_user.username
    build_password_hash = module.vault.data.build_user.password_hash
    build_uid = module.vault.data.build_user.uid
    build_ssh_key = module.vault.data.build_user.ssh_key
}

output "vsphere_vm_output" {
    value = module.vsphere_vm
    sensitive = true
}
