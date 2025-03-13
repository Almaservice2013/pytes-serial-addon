ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1

# Instalează pachetele necesare
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-setuptools \
    py3-wheel \
    py3-zope-interface \
    py3-mysqlclient \
    py3-paho-mqtt \
    py3-packaging \
    bash \
    jq \
    curl

# Copiază fișierele necesare pentru S6 Overlay
COPY rootfs/ /

# Instalare pachete Python lipsă
RUN pip install --no-cache-dir configparser datetime pytz pyserial
RUN pip install --no-cache-dir -r /config/requirements.txt

# Asigură-te că serviciul S6 este pornit corect
CMD [ "/init" ]
