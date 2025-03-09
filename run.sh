#!/bin/bash
echo "Starting Pytes Serial..."

# Creăm config.cfg din Home Assistant options
echo "[serial]" > /config/pytes_serial.cfg
echo "serial_port=${SERIAL_PORT}" >> /config/pytes_serial.cfg
echo "serial_baudrate=${BAUDRATE}" >> /config/pytes_serial.cfg
echo "reading_freq=10" >> /config/pytes_serial.cfg

echo "[MQTT]" >> /config/pytes_serial.cfg
echo "MQTT_broker=${MQTT_BROKER}" >> /config/pytes_serial.cfg
echo "MQTT_port=${MQTT_PORT}" >> /config/pytes_serial.cfg
echo "MQTT_topic=${MQTT_TOPIC}" >> /config/pytes_serial.cfg
echo "MQTT_active=true" >> /config/pytes_serial.cfg

# Rulează Pytes Serial
python3 /app/pytes_serial.py --config /config/pytes_serial.cfg
