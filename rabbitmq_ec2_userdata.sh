#!/bin/bash

# Update package lists
apt update -y

# Install software required for Ansible
apt install -y python3-pip

# Install Ansible using pip
pip3 install ansible

# Download the Ansible playbook from S3 (replace with your bucket and file path)
aws s3 cp s3://your-bucket/rabbitmq.yml /tmp/rabbitmq.yml

# Ensure proper permissions for downloaded playbook (optional, adjust based on your needs)
chmod 600 /tmp/rabbitmq.yml  # Set permissions to owner only (read/write)

# Run the Ansible playbook
ansible-playbook /tmp/rabbitmq.yml

# Clean up temporary file
rm -f /tmp/rabbitmq.yml
