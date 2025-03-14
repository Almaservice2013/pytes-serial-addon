ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1

# Instalează pachetele necesare pentru Python și sistem
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-virtualenv \
    py3-setuptools \
    py3-wheel \
    py3-mysqlclient \
    py3-paho-mqtt \
    py3-packaging \
    bash \
    bashio \
    jq \
    curl \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev \
    linux-headers

# Creare și activare mediu virtual Python
RUN python3 -m venv /config/venv && \
    /config/venv/bin/python -m ensurepip --default-pip && \
    /config/venv/bin/pip install --upgrade pip

# Setează mediu virtual în PATH
ENV PATH="/config/venv/bin:$PATH"

# Setare director de lucru
WORKDIR /config

# Copiere fișier requirements.txt
COPY requirements.txt /config/requirements.txt

# Instalare pachete Python în mediu virtual
RUN pip install --no-cache-dir -r /config/requirements.txt

# Copiază fișierele necesare pentru S6 Overlay și Home Assistant
COPY rootfs/ /

# Asigură-te că serviciul S6 este pornit corect
CMD [ "exec", "/init" ]
