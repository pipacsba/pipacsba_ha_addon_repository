#!/usr/bin/with-contenv bashio
set -e

# Pull upstream values from config
export UPSTREAM_HOST=$(bashio::config 'upstream_host')
export UPSTREAM_PORT=$(bashio::config 'upstream_port')

# Correct logic for HTTPS scheme
if bashio::config.true 'upstream_https'; then
    export UPSTREAM_SCHEME="https"
else
    export UPSTREAM_SCHEME="http"
fi

# Fixed: Use Supervisor API to get the port and parse with standard jq
export INGRESS_PORT=$(bashio::api.supervisor GET /addons/self/info | jq -r '.data.ingress_port')

bashio::log.info "Proxmox upstream: ${UPSTREAM_SCHEME}://${UPSTREAM_HOST}:${UPSTREAM_PORT}"
bashio::log.info "Ingress listening on port: ${INGRESS_PORT}"

mkdir -p /tmp/nginx/client_body /tmp/nginx/proxy

# Template the nginx config
envsubst '${UPSTREAM_HOST} ${UPSTREAM_PORT} ${UPSTREAM_SCHEME} ${INGRESS_PORT}' \
    < /etc/nginx/nginx.conf.template > /tmp/nginx.conf

echo "[INFO] Generated nginx config:"
cat /tmp/nginx.conf

# Create all needed temp directories in the writable /tmp partition
mkdir -p /tmp/nginx/client_body \
         /tmp/nginx/proxy \
         /tmp/nginx/fastcgi \
         /tmp/nginx/uwsgi \
         /tmp/nginx/scgi

nginx -c /tmp/nginx.conf -g "daemon off;"
