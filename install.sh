bash
#!/bin/bash

# Define versions
erlang_version="23.2.7"
rabbitmq_version="3.8.9"

# Update system
sudo apt-get update

# Check if wget is installed
if ! command -v wget &> /dev/null
then
    echo "wget could not be found, installing now..."
    sudo apt-get install wget -y
fi

# Check if curl is installed
if ! command -v curl &> /dev/null
then
    echo "curl could not be found, installing now..."
    sudo apt-get install curl -y
fi

# Install Erlang/OTP
echo "Installing Erlang/OTP..."
wget https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_${erlang_version}-1~ubuntu~focal_amd64.deb
sudo dpkg -i esl-erlang_${erlang_version}-1~ubuntu~focal_amd64.deb
sudo apt-get update
sudo apt-get install -f

# Install RabbitMQ
echo "Installing RabbitMQ..."
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.deb.sh | sudo bash
sudo apt-get install rabbitmq-server=${rabbitmq_version}-1

# Enable RabbitMQ service
echo "Enabling RabbitMQ service..."
sudo systemctl enable rabbitmq-server

# Start RabbitMQ service
echo "Starting RabbitMQ service..."
sudo systemctl start rabbitmq-server

# Check status of RabbitMQ service
echo "Checking RabbitMQ service status..."
sudo systemctl status rabbitmq-server

