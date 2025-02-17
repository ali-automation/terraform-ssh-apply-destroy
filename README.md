
# Terraform SSH Key Deployment

This Terraform script automates copying an SSH public key to multiple target servers and provides a mechanism to remove the keys when destroying the infrastructure.

## 📌 Overview

- **`main.tf`**: Defines the Terraform configuration, including variables for the SSH username and key path.
- **`hosts.txt`**: Contains the list of target servers where the SSH public key will be copied.
- **`remove_ssh_keys.sh`**: Bash script to remove the copied SSH key from target servers.

---

## 📂 File Structure

```
.
├── main.tf                # Terraform configuration
├── hosts.txt              # List of target servers
└── remove_ssh_keys.sh     # Script to remove SSH keys
```

---

## 🔧 Terraform Configuration (main.tf)

### Variables
- `ssh_user`: SSH username (default: `ali-automation`)
- `ssh_key_path`: Path to the public SSH key (default: `~/.ssh/id_rsa.pub`)

### Resources
- **`null_resource.ssh_copy_id`**:
  - Copies the SSH public key to the servers listed in `hosts.txt` using `sshpass` and `ssh-copy-id`.
  - Removes the SSH key using `remove_ssh_keys.sh` upon `terraform destroy`.

---

## 📄 hosts.txt

List of target server IP addresses, one per line.

**Example:**
```
10.10.10.2
10.10.10.3
10.10.10.4
```

---

## 🛠️ remove_ssh_keys.sh

A bash script to remove the SSH public key from the `~/.ssh/authorized_keys` file of each target server.

**Key Points:**
- Uses `sed` to remove the SSH public key line from `authorized_keys`.
- Reads the host IPs from `hosts.txt`.

---

## 🚀 Usage

### 1. Initialize Terraform
```sh
terraform init
```

### 2. Apply Configuration
```sh
terraform apply -var "ssh_user=<your_username>" -var "ssh_key_path=<path_to_public_key>"
```

- Replace `<your_username>` and `<path_to_public_key>` with your SSH username and the path to your public key.

### 3. Destroy Configuration
```sh
terraform destroy
```

- This will trigger `remove_ssh_keys.sh` to remove SSH keys from all hosts.

---

## 🔑 SSH Password
- Ensure that the environment variable `SERVERS_PASS` is set with the SSH password before running `terraform apply`.

---

## ⚠️ Prerequisites

- **Terraform** installed.
- **sshpass** installed for non-interactive SSH password authentication.
- **Valid SSH key pair** generated.

---

## 📝 Note
- Modify the `hosts.txt` file to include the IP addresses of your target servers.
- Ensure the `ssh_user` has permission to add/remove SSH keys on the target servers.

---

✅ Happy Automation! 🛠️
