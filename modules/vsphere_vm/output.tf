# Outputs for vSphere VM Module

output "vm_name" {
    value = var.vm_name
}

output "ip_address" {
    value = vsphere_virtual_machine.vm.default_ip_address
}

output "root_password" {
    value = random_password.root.result
    sensitive = true
}
