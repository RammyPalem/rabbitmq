#!/bin/bash

# Import the Erlang Solutions GPG key
wget -O - https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -

# Add the Erlang Solutions repository
echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | sudo tee /etc/apt/sources.list.d/erlang-solutions.list

# Update package lists
sudo apt-get update

# Install Erlang and RabbitMQ without prompts
sudo apt-get install -y erlang-nox rabbitmq-server

# Enable RabbitMQ plugins
sudo rabbitmq-plugins enable rabbitmq_management

# Create an admin user and set administrator tag and permissions
sudo rabbitmqctl add_user admin your_password
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

# Set the HA mode policy to "all" and HA sync mode to "automatic" for all queues
echo "[{rabbit, [{default_ha_params, [{ha_mode, 'all'}, {ha_sync_mode, 'automatic'}]}]}]." | sudo tee -a /etc/rabbitmq/rabbitmq.config

# Restart RabbitMQ to apply the changes
sudo service rabbitmq-server restart