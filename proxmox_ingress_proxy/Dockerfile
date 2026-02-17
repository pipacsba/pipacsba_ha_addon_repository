# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache nginx jq bash gettext

COPY rootfs /

RUN chmod +x /run.sh && \
    mkdir -p /run/nginx && \
    mkdir -p /var/lib/nginx/tmp && \
    mkdir -p /var/lib/nginx/logs && \
    chown -R nginx:nginx /run/nginx /var/lib/nginx

EXPOSE 8098

CMD ["/run.sh"]
