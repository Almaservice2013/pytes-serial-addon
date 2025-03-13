ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1

# Instalează pachetele necesare pentru Home Assistant
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

# Asigură-te că pip este actualizat și funcțional
RUN python3 -m pip install --upgrade pip

# Creare și setare director de lucru
RUN mkdir -p /app
WORKDIR /app

# Copiere fișiere Python și de configurare
COPY requirements.txt /app/requirements.txt
COPY pytes_serial.py /app/pytes_serial.py
COPY rootfs/ /

# Instalare pachete Python din requirements.txt
RUN python3 -m pip install --no-cache-dir -r /app/requirements.txt

# Asigură-te că serviciul S6 este pornit corect
CMD [ "/init" ]
