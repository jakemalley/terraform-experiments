# Variables for Ansible Vault module
variable "vault_file" {
    description = "Ansible Vault File"
    type = string
}

variable "password_file" {
    description = "Ansible Vault Password File (--vault-password-file)"
    type = string
}

variable "working_directory" {
    description = "Working directory for Ansible Vault commands"
    type = string
    default = null
}