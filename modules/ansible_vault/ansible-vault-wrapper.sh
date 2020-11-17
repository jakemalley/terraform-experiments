#!/usr/bin/env bash

# Wrapper for Ansible Vault (ansible-vault)
# Returns a JSON object with {"data": "<vault file contents, encoded in base64>"}
# Requires ansible-vault CLI!

echo -n "{\"data\": \"$(ansible-vault view --vault-password-file=$1 $2 | base64 -w0)\"}"
