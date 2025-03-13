ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1

# Instalează dependențe esențiale
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-setuptools \
    py3-wheel \
    py3-mysqlclient \
    py3-paho-mqtt \
    py3-packaging \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev \
    linux-headers

# Repară potențiale probleme cu Python și pip
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

# **Evită probleme cu pip: forțează utilizarea pachetului standard**
RUN python3 -m ensurepip --default-pip
RUN python3 -m pip install --upgrade --no-cache-dir pip setuptools wheel

# Setare director de lucru
WORKDIR /config

# Copiere fișier requirements.txt
COPY requirements.txt /config/requirements.txt

# Instalare pachete Python din requirements.txt
RUN python3 -m pip install --no-cache-dir -r /config/requirements.txt

# Copiază fișierele necesare pentru S6 Overlay și Home Assistant
COPY rootfs/ /

# Asigură-te că serviciul S6 este pornit corect
CMD [ "/init" ]
