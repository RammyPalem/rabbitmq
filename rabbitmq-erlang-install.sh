#!/bin/bash

# Function to check and install packages
check_and_install() {
  package_name="$1"
  if ! dpkg -l | grep -q $package_name; then
    echo "Installing $package_name..."
    sudo apt-get install -y $package_name
  fi
}

# Check for Erlang and RabbitMQ dependencies
check_and_install "build-essential"
check_and_install "erlang-nox"
check_and_install "esl-erlang"

# Download and install Erlang
wget https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_20.3-1~ubuntu~bionic_amd64.deb
sudo dpkg -i esl-erlang_20.3-1~ubuntu~bionic_amd64.deb
sudo apt-get update -y
sudo apt-get install -y esl-erlang

# Download and install RabbitMQ
sudo apt-get install -y rabbitmq-server

# Enable RabbitMQ plugins
sudo rabbitmq-plugins enable rabbitmq_management

# Create an admin user and set administrator tag and permissions
sudo rabbitmqctl add_user admin your_password
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

# Start RabbitMQ
sudo service rabbitmq-server start

# Set the HA mode policy to "all"
sudo rabbitmqctl set_policy HA ".*" '{"ha-mode":"all"}' --priority 0 --apply-to queues

# Check RabbitMQ status
sudo rabbitmqctl status