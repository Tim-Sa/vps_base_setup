# Ansible Playbook Setup Guide

## Overview

This repository contains an Ansible playbook designed to automate the setup and configuration of a Virtual Private Server (VPS). The playbook performs the following tasks:

- Installs necessary packages, including Docker and Nginx.
- Creates a new user with specified privileges.
- Configures SSH for secure access.
- Sets up a basic firewall using UFW (Uncomplicated Firewall).

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Getting Started](#getting-started)
   - [Environment Variables](#environment-variables)
   - [Inventory File](#inventory-file)
   - [Makefile](#makefile)
3. [Running the Playbook](#running-the-playbook)
4. [Playbook Tasks Overview](#playbook-tasks-overview)
5. [Customization](#customization)
6. [License](#license)
7. [Contributors](#contributors)

## Prerequisites

Before you begin, ensure you have the following set up:

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed on your local machine or control node.
- Access credentials for the VPS where you want to deploy.
- SSH keys configured for secure access.
- The required packages: `whois`, `ufw`, and `apt-transport-https` should be available in your package manager.

## Getting Started

### Environment Variables

Prepare a `.env` file by copying the provided example:

```bash
make create_env
```

Edit the `.env` file to set the following variables:

```env
USER_NAME=your_user
USER_PASSWORD=yoursecurepassword
ACCESS_SSH_PUBLIC_KEY_PATH=/path/to/your/ssh_public_key.pub
```

### Inventory File

Create an inventory file (e.g., `hosts.ini`) specifying the target VPS:

```ini
[vps]
your_server_ip ansible_ssh_user=your_user ansible_ssh_pass=your_password
```

### Makefile

This repository includes a Makefile for easy command execution:

#### Copies the example .env file for configuration.

```bash
make create_env
```

#### Pings the server to verify connectivity.

```bash
make test
```

#### Executes the Ansible playbook to set up the VPS with the configuration defined in the playbook.

```bash
make run
```

## Running the Playbook


To execute the Ansible playbook, you have two options:


### Using Makefile


Run the setup with:


```bash

make run
```

Or directly with full command:

```bash

set -a && . ./.env && set +a && ansible-playbook -i hosts.ini setup.yml --ssh-common-args='-o PubkeyAuthentication=no -o PreferredAuthentications=password'
```

## Playbook Tasks Overview

The playbook performs the following tasks:

1. **Ensure `mkpasswd` is installed** to generate encrypted passwords.
2. **Generate an encrypted password** for the new user.
3. **Create a new user** with a home directory and shell access.
4. **Configure the new user** to run `sudo` commands without a password.
5. **Update and upgrade apt packages**.
6. **Install necessary packages for Docker**.
7. **Add Docker GPG key and repository** to install Docker CE.
8. **Add the new user to the Docker group**.
9. **Create an `.ssh` directory** for the new user.
10. **Copy the SSH public key** to the authorized keys.
11. **Ensure UFW is installed and enabled**, allowing OpenSSH.
12. **Ensure Nginx is installed**.
13. **Check available UFW application profiles**.
14. **Allow HTTP and HTTPS traffic** through the firewall if profiles exist.
15. **Configure SSH** for public key authentication and set max authentication tries.
16. **Disable root login and password authentication**.
17. **Restart SSH service** to apply all changes.

## Customization

You can customize the playbook by modifying the following:

- **User variables**: Change `USER_NAME` and `USER_PASSWORD` in the `.env` file.
- **SSH settings**: Modify the relevant tasks in the playbook to fit your security policies or preferences.
- **Additional packages**: Add or remove packages in the step that installs required packages for Docker.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

