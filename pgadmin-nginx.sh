#!/bin/bash

# Update package lists
sudo apt-get update

# Install necessary packages (e.g., pgadmin4 dependencies)
# Adjust this based on your specific distribution and package manager
# For example, on Ubuntu, you might use:
# sudo apt-get install -y pgadmin4

# Start Nginx
sudo service nginx start

# Configure pgAdmin to listen on all addresses
# This sed command modifies the pgAdmin configuration file to allow connections from any address
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/pgadmin4/pgadmin4.conf

# Start pgAdmin service
sudo service pgadmin4 start

# Create an Nginx configuration snippet file
echo "server {
    listen 443 ssl;
    server_name lwqqm-internal-pgadmin.example.com;

    ssl_certificate /path/to/your/certificate.crt;
    ssl_certificate_key /path/to/your/private-key.key;

    location / {
        proxy_pass http://127.0.0.1:5050;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_redirect off;
    }
}" | sudo tee /etc/nginx/conf.d/internal-nginx.conf

# Include the Nginx configuration snippet from the main configuration
sudo sed -i '/include \/etc\/nginx\/sites-available\//a \    include /etc/nginx/conf.d/internal-nginx.conf;' /etc/nginx/nginx.conf

# Restart Nginx to apply the changes
sudo service nginx restart

echo "Installation completed. Access pgAdmin at https://lwqqm-internal-pgadmin.example.com"