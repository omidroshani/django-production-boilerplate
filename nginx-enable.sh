#!/bin/bash

NGINX_CONF="/etc/nginx/nginx.conf"
SITES_ENABLED="/etc/nginx/sites-enabled"

# Check if the nginx.conf file exists
if [ ! -f "$NGINX_CONF" ]; then
    echo "nginx.conf file not found."
    exit 1
fi

# Check if the sites-enabled directory exists
if [ ! -d "$SITES_ENABLED" ]; then
    echo "sites-enabled directory not found."
    exit 1
fi

# Add the include statement to the nginx.conf file
sed -i '/http {/a \    include \/etc\/nginx\/sites-enabled\/*\;' $NGINX_CONF

# Check if the modification was successful
if [ $? -eq 0 ]; then
    echo "Include statement added to nginx.conf successfully."
else
    echo "Failed to add the include statement to nginx.conf."
    exit 1
fi

# Test the Nginx configuration
nginx -t

# If the configuration test is successful, restart Nginx
if [ $? -eq 0 ]; then
    systemctl restart nginx
    echo "Nginx restarted successfully."
else
    echo "Nginx configuration test failed. Restart aborted."
fi
