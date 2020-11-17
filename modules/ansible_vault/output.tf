# Output from Ansible Vault
output "result" {
    description = "Raw result from Ansible-Vault"
    value = local.result
    sensitive = true
}

output "base64" {
    description = "Base64 encoded result from Ansible-Vault"
    value = local.base64
    sensitive = true
}

output "data" {
    description = "Raw result from Ansible-Vault"
    value = local.data
    sensitive = true
}
