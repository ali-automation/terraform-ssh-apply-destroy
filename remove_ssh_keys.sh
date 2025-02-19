#!/bin/bash

SSH_USER="user"
SSH_KEY_PATH=$HOME/.ssh/id_rsa.pub

# Escape the public key to avoid sed errors
ESCAPED_KEY=$(sed 's/[\/&]/\\&/g' $SSH_KEY_PATH)

# Read hosts from hosts.txt
mapfile -t HOSTS < hosts.txt

for host in "${HOSTS[@]}"; do
  echo "Removing SSH key from $host"
  ssh $SSH_USER@$host "sed -i '/$ESCAPED_KEY/d' ~/.ssh/authorized_keys"
done
