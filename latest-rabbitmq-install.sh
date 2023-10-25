#!/bin/bash

# Check for and install dependencies
echo "Checking and installing dependencies..."
sudo apt-get update
sudo apt-get install -y wget gnupg

# Download and install Erlang
echo "Downloading and installing Erlang..."
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update
sudo apt-get install -y erlang

# Download and install RabbitMQ
echo "Downloading and installing RabbitMQ..."
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.9.7/rabbitmq-server_3.9.7-1_all.deb
sudo dpkg -i rabbitmq-server_3.9.7-1_all.deb
sudo apt-get -f install

# Enable RabbitMQ management plugin
echo "Enabling RabbitMQ management plugin..."
sudo rabbitmq-plugins enable rabbitmq_management

# Create admin user and grant permissions
echo "Creating admin user..."
sudo rabbitmqctl add_user admin admin
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

echo "Installation completed successfully!"
