#!/bin/bash

CONFIG_PATH=/data/options.json

MQTTUSER="$(jq --raw-output '.mqttUser' $CONFIG_PATH)"
MQTTPASSWORD="$(jq --raw-output '.mqttPassword' $CONFIG_PATH)"

sed -i 's/= devinput/= default/g' /etc/lirc/lirc_options.conf

sed -i 's/= auto/= \/dev\/lirc0/g' /etc/lirc/lirc_options.conf

lircd -l -L /home/lirc_log
lirc2mqtt --url mqtt://$MQTTUSER:$MQTTPASSWORD@homeassistant:1883
