server {
    server_name ${DOMAIN}; # Domain on the Domain provider

    client_max_body_size 20M;  # Adjust the size limit as needed

    location / {
        proxy_pass http://localhost:${PORT}; # local running app to be forwarded
        proxy_read_timeout 300s;
        proxy_send_timeout 300s;

        # Added for reverse proxy config.
        proxy_redirect     off;
        proxy_set_header   Host                 $host;
        proxy_set_header   X-Real-IP            $remote_addr;
        proxy_set_header   X-Forwarded-For      $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto    $scheme;
    }

    listen 80;

    # Write access and error logs to /var/log
    access_log /var/log/${DOMAIN}_access.log;
    error_log /var/log/${DOMAIN}_error.log;
} 