# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN rm -rf /app

WORKDIR /app

RUN \
    set -x \
    && apk add --no-cache \
        git \
        libuv \
        mosquitto-clients \
        nano \
        openssh-client \
        python3 \
        py3-pip \
        tzdata \
    \
    && git clone \
        https://github.com/pipacsba/timekpr-mngr.git /app/ \
    && git pull \
    \
    && rm -f -r \
        /root/.cache \
        /root/.cmake \
        /tmp/*

RUN rm -rf /app/instance \
    && ln -s /data /app/instance

RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy root filesystem
COPY rootfs /
RUN chmod +x /etc/services.d/timekpr_mngr/run \
    && chmod +x /etc/services.d/timekpr_mngr/finish \
    && chmod +x /etc/services.d/watchdog/run
