# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache nginx jq bash gettext

COPY rootfs /

RUN chmod +x /run.sh && \
    mkdir -p /run/nginx && \
    mkdir -p /var/lib/nginx/tmp && \
    chown -R nginx:nginx /run/nginx /var/lib/nginx

EXPOSE 8099

CMD ["/run.sh"]
