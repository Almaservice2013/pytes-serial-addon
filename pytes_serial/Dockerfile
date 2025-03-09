ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-setuptools \
    py3-wheel

WORKDIR /app

COPY requirements.txt /app/requirements.txt
COPY run.sh /app/run.sh
COPY pytes_serial.py /app/pytes_serial.py

RUN pip install --no-cache-dir -r /app/requirements.txt

RUN chmod +x /app/run.sh

CMD [ "/app/run.sh" ]
