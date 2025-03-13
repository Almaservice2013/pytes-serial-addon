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

# Setare director de lucru
WORKDIR /config

# Repară potențiale probleme cu pip în Alpine Linux
RUN python3 -m ensurepip --default-pip
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Copiere fișier requirements.txt
COPY requirements.txt /config/requirements.txt

# Instalare pachete Python din requirements.txt
RUN pip install --no-cache-dir -r /config/requirements.txt

# Copiază fișierele necesare pentru S6 Overlay și Home Assistant
COPY rootfs/ /

# Asigură-te că serviciul S6 este pornit corect
CMD [ "/init" ]
