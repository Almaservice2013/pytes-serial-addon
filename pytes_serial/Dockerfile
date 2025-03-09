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
    py3-packaging

# Creare mediu virtual pentru instalarea dependențelor
RUN python3 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"

# Copiere fișiere
WORKDIR /app
COPY requirements.txt /app/requirements.txt
COPY run.sh /app/run.sh
COPY pytes_serial.py /app/pytes_serial.py

# Instalare pachete Python lipsă în mediu virtual
RUN /app/venv/bin/pip install --no-cache-dir configparser datetime pytz pyserial
RUN /app/venv/bin/pip install --no-cache-dir -r /app/requirements.txt

# Asigură-te că scriptul este executabil
RUN chmod +x /app/run.sh

CMD [ "/app/run.sh" ]
