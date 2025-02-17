variable "ssh_user" {
  default = "ali-automation"  # Change this to your SSH username
}

variable "ssh_key_path" {
  default = "~/.ssh/id_rsa.pub"   # Path to your public SSH key
}

resource "null_resource" "ssh_copy_id" {
  # Bellow will copy your ssh public key to target servers authorized_keys
  provisioner "local-exec" {
    command = <<EOT
      export SSHPASS="$SERVERS_PASS"
      cat hosts.txt | xargs -I {} sshpass -e ssh-copy-id -o StrictHostKeyChecking=no ${var.ssh_user}@{}
    EOT
  }

    provisioner "local-exec" {
    when = destroy
    command = "bash ./remove_ssh_keys.sh"
  }
}