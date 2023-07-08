#!/bin/bash

set -e

source .env

remove=""
BASE_URL=${BASE_URL/http:\/\//$remove}
BASE_URL=${BASE_URL/https:\/\//$remove}

echo $BASE_URL

export DOMAIN=$BASE_URL
export PORT=$DJANGO_PORT

# Avoid replacing these with envsubst
export host=\$host
export remote_addr=\$remote_addr
export proxy_add_x_forwarded_for=\$proxy_add_x_forwarded_for
export scheme=\$scheme


envsubst  < nginx.conf.tpl > /etc/nginx/sites-available/${BASE_URL}

ln -sf /etc/nginx/sites-available/${BASE_URL} /etc/nginx/sites-enabled/${BASE_URL}

service nginx restart

certbot --nginx -d ${BASE_URL} --non-interactive