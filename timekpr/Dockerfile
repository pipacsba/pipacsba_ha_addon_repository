# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

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
        https://github.com/pipacsba/timekpr-webui.git /app/ \
    \
    && rm -f -r \
        /root/.cache \
        /root/.cmake \
        /tmp/*

# Create instance directory for Flask app data (database)
# RUN mkdir -p /app/instance && chmod 777 /app/instance
# Remove instance if it exists
RUN rm -rf /app/instance \
    && ln -s /data /app/instance

#COPY requirements.txt .
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy application code - replaced by git clone above
COPY hass_wrapper_gunicorn.py .

# Set environment variables
ENV FLASK_APP=/app/app.py
ENV FLASK_ENV=production

# Expose the port the app runs on
#EXPOSE 5001

# Command to run the application
#CMD ["gunicorn", "--bind", "0.0.0.0:5001", "app:app"]

# Copy root filesystem
COPY rootfs /
RUN chmod +x /etc/services.d/timekpr/run \
    && chmod +x /etc/services.d/timekpr/finish \
    && chmod +x /etc/services.d/watchdog/run
