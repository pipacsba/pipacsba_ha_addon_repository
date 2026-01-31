# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

#edge version copy main branch
#ARG TIMEKPR_MNGR_VERSION=1.0.1

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
    #use the dev branch
    git clone --depth 1 -b dev --single-branch \
        https://github.com/pipacsba/timekpr-mngr.git /app/ \
    \
    && rm -f -r \
        /root/.cache \
        /root/.cmake \
        /tmp/* \
    && git -C /app pull
        
RUN rm -rf /app/instance \
    && ln -s /data /app/instance

RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy root filesystem
COPY rootfs /
RUN chmod +x /etc/services.d/timekpr_mngr/run \
    && chmod +x /etc/services.d/timekpr_mngr/finish \
    && chmod +x /etc/services.d/watchdog/run
