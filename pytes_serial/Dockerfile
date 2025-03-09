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
    py3-configparser \
    py3-datetime \
    py3-pytz \
    py3-zope-interface \
    py3-mysqlclient \
    py3-paho-mqtt \
    py3-packaging \
    py3-serial

# Creare mediu virtual pentru instalarea dependențelor
RUN python3 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"

# Instalare dependențe Python în mediu virtual
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

WORKDIR /app
COPY run.sh /app/run.sh
COPY pytes_serial.py /app/pytes_serial.py

RUN chmod +x /app/run.sh

CMD [ "/app/run.sh" ]
