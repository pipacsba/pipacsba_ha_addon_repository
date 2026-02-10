ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache nginx jq bash gettext

COPY rootfs /

RUN chmod +x /etc/cont-init.d/01-nginx.sh && \
    mkdir -p /run/nginx && \
    mkdir -p /var/lib/nginx/tmp && \
    chown -R nginx:nginx /run/nginx /var/lib/nginx

EXPOSE 8099

CMD ["/init"]
