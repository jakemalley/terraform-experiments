
provider "vsphere" {
    user = module.vault.data.terraform.vsphere_user
    password = module.vault.data.terraform.vsphere_password
    vsphere_server = module.vault.data.terraform.vsphere_server
    allow_unverified_ssl = module.vault.data.terraform.allow_unverified_ssl
}
