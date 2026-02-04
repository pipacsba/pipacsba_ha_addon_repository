# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

ARG TIMEKPR_MNGR_VERSION=1.2.0

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN rm -rf /app


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
        mailcap 

WORKDIR /app

RUN echo ${TIMEKPR_MNGR_VERSION}
    
RUN \
    #remove -b dev --single-branch when going back to main
    git clone --depth 1 --branch ${TIMEKPR_MNGR_VERSION} \
        https://github.com/pipacsba/timekpr-mngr.git /app/ \
    && git -C /app pull \
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
