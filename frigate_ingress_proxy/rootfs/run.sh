#!/usr/bin/env bash
set -e

UPSTREAM_HOST="$(jq -r '.upstream_host' /data/options.json)"
UPSTREAM_PORT="$(jq -r '.upstream_port' /data/options.json)"
UPSTREAM_HTTPS="$(jq -r '.upstream_https' /data/options.json)"

if [ "$UPSTREAM_HTTPS" = "true" ]; then
  UPSTREAM_SCHEME="https"
else
  UPSTREAM_SCHEME="http"
fi

export UPSTREAM_HOST UPSTREAM_PORT UPSTREAM_SCHEME

echo "[INFO] Frigate upstream: ${UPSTREAM_SCHEME}://${UPSTREAM_HOST}:${UPSTREAM_PORT}"

mkdir -p /tmp/nginx/client_body /tmp/nginx/proxy

envsubst '${UPSTREAM_SCHEME} ${UPSTREAM_HOST} ${UPSTREAM_PORT}' \
  < /etc/nginx/nginx.conf.template \
  > /tmp/nginx.conf

echo "[INFO] Generated nginx config:"
cat /tmp/nginx.conf

# Create all needed temp directories in the writable /tmp partition
mkdir -p /tmp/nginx/client_body \
         /tmp/nginx/proxy \
         /tmp/nginx/fastcgi \
         /tmp/nginx/uwsgi \
         /tmp/nginx/scgi

nginx -c /tmp/nginx.conf -g "daemon off;"
