#!/usr/bin/env bash

# Add Local Ansible User
useradd -c 'Local Ansible Operations User' -e -1 -u ${user_uid} -p '${password_hash}' ${user}
echo '${user} ALL=(ALL) NOPASSWD : ALL' > /etc/sudoers.d/99-${user}
mkdir -p /home/${user}/.ssh
echo '${ssh_key}' > /home/${user}/.ssh/authorized_keys
chown -R '${user}:${user}' /home/${user}/.ssh
chmod -R 'u=rwX,g=-,o=-' /home/${user}/.ssh

# Change root's password
echo 'root:${root_password}' | chpasswd -c SHA512

# Disable cloud-init
touch /etc/cloud/cloud-init.disabled

# Remove and regenerate machine-id
rm -f /etc/machine-id /var/lib/dbus/machine-id
dbus-uuidgen --ensure
systemd-machine-id-setup
