module "vault" {
    source = "../modules/ansible_vault"

    vault_file = "../vault/example_vault.yml"
    password_file = "../vault/example_vault_password"
}

module "vsphere_vm" {
    source = "../modules/vsphere_vm"

    count = length(var.lab)

    datacenter = var.lab[count.index].datacenter
    datastore = var.lab[count.index].datastore
    resource_pool = var.lab[count.index].resource_pool
    folder = var.lab[count.index].folder
    network = var.lab[count.index].network
    network_type = var.lab[count.index].network_type
    network_options = var.lab[count.index].network_options
    dns_domain = var.lab[count.index].dns_domain
    template = var.lab[count.index].template

    vm_name = var.lab[count.index].vm_name
    num_cpus = var.lab[count.index].num_cpus
    memory = var.lab[count.index].memory
    additional_disks = var.lab[count.index].additional_disks

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