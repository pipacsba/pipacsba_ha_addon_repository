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

envsubst '${UPSTREAM_SCHEME} ${UPSTREAM_HOST} ${UPSTREAM_PORT}' \
  < /etc/nginx/nginx.conf.template \
  > /etc/nginx/nginx.conf

exec nginx -g "daemon off;"
