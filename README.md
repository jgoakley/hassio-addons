# Hass.io Add-ons for Home Assistant

## About

This repository collects all of my Hass.io add-ons for easier installation.

## Disclaimer / Potential Issues

I have no idea what I'm doing. These Add Ons are a some pet projects I've been working on in my spare time. Here's a couple of things that I think I'm doing wrong but not sure how to fix:
1. These addons use base images from raspbian and hassioaddons. I think I should be creating images in dockerhub and using those. Not sure how to do that yet. As a result I think the installation of the add ons takes longer and uses more storage space than they otherwise would.
2. I'm using third party libraries that could change at any time and potentially break stuff (ex. weewx and lirc). I think the solution may be to target specific versions.
3. Speaking of third party libraries, I install npm for the sole purpose of grabbing the lirc2mqtt library. Probably a better approach there.
4. I think there's a better way to set up the configuration options to indicate which fields are required. I'm pretty sure they are all required for everything to work, but some probably don't need to be required
5. There's probably more stuff I'm doing wrong so feel free to create a pull request if you know the right way. Thanks!


## Installation

Follow [the official instructions](https://home-assistant.io/hassio/installing_third_party_addons/) on the Home Assistant website and use the following URL:
```txt
https://github.com/jgoakley/hassio-addons
```

## Add-ons provided by this repository


## WeeWX
Uses the WeeWX Library and MQTT to receive data from a weather station.

#### Example configuration:
```
{
  "driver": "weewx.drivers.acurite",
  "latitude": 12.345678,
  "longitude": -12.345678,
  "altitude": 123,
  "altitudeUnit": "foot",
  "location": "Location String for WeeWX",
  "units": "us",
  "mqttUser": "MQTTUserName",
  "mqttPassword": "MQTTPassword"
}
```

## LIRC
Uses the Linux Infrared Remote Control Library and MQTT to send and receive infrared commands with a Raspberry Pi.

** Update: I don't think this installs with current versions of Home Assistant (Anything newer than mid-2019). I no longer use a Raspberry Pi to host Home Assistant (I use a Linux server with a KVM virtual machine) and I have not attempted to get this working on any hardware other than the Raspberry Pi GPIO. Leaving here in case it is helpful for anyone **

#### Example configuration:
```
{
  "mqttUser": "MQTTUserName",
  "mqttPassword": "MQTTPassword"
}
```
