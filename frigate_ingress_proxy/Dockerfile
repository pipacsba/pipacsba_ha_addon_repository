# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN rm -rf /app

RUN apk add --no-cache nginx jq bash gettext

COPY rootfs /

RUN chmod +x /etc/cont-init.d/01-nginx.sh && \
    mkdir -p /run/nginx && \
    mkdir -p /var/lib/nginx/tmp && \
    chown -R nginx:nginx /run/nginx /var/lib/nginx

EXPOSE 8099

CMD ["/init"]
