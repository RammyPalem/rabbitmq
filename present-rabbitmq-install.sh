#!/bin/bash

#Install prerequisites
sudo apt-get update
sudo apt-get install wget apt-transport-https -y

# Add RabbitMQ repository key
wget -0- https://www.rabbitmq-release-signing-key.asc  | sudo apt-key add -

#Add RabbitMQ Repository
echo "deb https://dl.bintray.com/rabbitmq-erlang/debian focal erlang-22.x" | sudo tee /etc/apt/sources.list.d/rabbitmq.list

#Install RabbitMQ Server
sudo apt-get update
sudo apt-get install rabbitmq-server -y --fix-missing

#Enable RabbitMQ management plugin
sudo rabbitmq-plugins enable rabbitmq_management webmachine rabbitmq_management_agent amqp_client rabbitmq_web_dispatch  rabbitmq_amqp1_0 rabbitmq_federation rabbitmq_federation_management rabbitmq_shovel  rabbitmq_shovel_management

#set user and  Password fro RabbitMQ console

sudo rabbitmqctl add_user 'admin' 'admin'
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin  ".*" ".*" ".*"

#start RabbitMQ server
sudo systemctl start rabbitmq-server
sudo rabbitmqctl start_app
sudo rabbitmqctl set_policy ha "." '{"ha-mode":"all"}'

#Display RabbitMQ status
sudo systemctl status  rabbitmq-server

# Exit the script
exit 

