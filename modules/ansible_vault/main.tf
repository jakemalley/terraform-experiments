## Module for retrieving data from Ansible Vault
## Requires ansible-vault cli.

## Example:
## $ echo '{"key": "value"}' > v_example
## $ echo "my super secret password" > p_example
## $ ansible-vault encrypt --vault-password-file=p_example v_example
## Note remember to set correct file permissions e.g. chmod 600

# Ansible Vault Data Source - Requires ansible-vault
data "external" "ansible_vault" {
    program = [
        "bash",
        "--",
        "${path.module}/ansible-vault-wrapper.sh",
        var.password_file,
        var.vault_file
    ]
    working_dir = var.working_directory
}

# Transform result into something useable
locals {
    result = data.external.ansible_vault.result
    base64 = local.result.data
    data = try(yamldecode(base64decode(local.base64)), null)
}
