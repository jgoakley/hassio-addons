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
Uses the WeeWX Library and MQTT to receive data from a weather station. Weather stations such as the AcuRite 01036M (the only one I have tested this with) have a USB B-mini port in the display unit that receives the signal from the weather station. Plugging a USB cable from the display into your Home Assistant machine should show a device when running the ```lsusb``` command. If you are using a Raspberry Pi you should be able to use the SSH addon to connect to your Home Assistant instance and run the command from there:

```
~$ lsusb
Bus 002 Device 004: ID 24c0:0003
```

For my AcuRite weather station it shows up as "Chaney Instrument" in some utilities (but for some reason not the lsusb command)

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

Here is an example of some Home Assistant configuration.yaml entries for sensors that can be used for an AcuRite 01036M weather station. Each sensor is published with the MQTT channel of "weather" and set to US units. These should probably be configurable and included in the settings above but I haven't got around to that yet.

```
sensor:
  - platform: mqtt
    state_topic: "weather/windSpeed_mph"
    name: "Wind Speed"
    unit_of_measurement: 'mph'
    value_template: "{{ value | round(1) }}"
    icon: "mdi:weather-windy-variant"
  - platform: mqtt
    state_topic: "weather/windGust_mph"
    name: "Wind Gust"
    unit_of_measurement: 'mph'
    value_template: "{{ value | round(1) }}"
    icon: "mdi:weather-windy"
  - platform: mqtt
    state_topic: "weather/outTemp_F"
    name: "Outdoor Temperature"
    unit_of_measurement: 'F'
    device_class: 'temperature'
    value_template: "{{ value | round(1) }}"
    icon: "mdi:thermometer"
  - platform: mqtt
    state_topic: "weather/humidex_F"
    name: "Humidex"
    unit_of_measurement: 'F'
    device_class: 'temperature'
    value_template: "{{ value | round(1) }}"
    icon: "mdi:thermometer"
  - platform: mqtt
    state_topic: "weather/heatindex_F"
    name: "Heat Index"
    unit_of_measurement: 'F'
    device_class: 'temperature'
    value_template: "{{ value | round(1) }}"
    icon: "mdi:thermometer"
  - platform: mqtt
    state_topic: "weather/outHumidity"
    name: "Outdoor Humidity"
    unit_of_measurement: '%'
    value_template: "{{ value | round(1) }}"
    icon: "mdi:water-percent"
  - platform: mqtt
    state_topic: "weather/barometer_inHg"
    name: "Air Pressure"
    unit_of_measurement: "inHg"
    value_template: "{{ value | round(3) }}"
    icon: "mdi:gauge"
  - platform: mqtt
    state_topic: "weather/windDir"
    name: "Wind Direction"
    unit_of_measurement: "degrees"
    value_template: "{{ value | round(1) }}"
    icon: "mdi:compass"
  - platform: mqtt
    state_topic: "weather/windGustDir"
    name: "Wind Gust Direction"
    unit_of_measurement: "degrees"
    value_template: "{{ value | round(1) }}"
    icon: "mdi:compass"
  - platform: mqtt
    state_topic: "weather/rainRate_inch_per_hour"
    name: "Rain Rate"
    unit_of_measurement: "in/hour"
    value_template: "{{ value | round(4) }}"
    icon: "mdi:weather-rainy"
  - platform: mqtt
    state_topic: "weather/rain_in"
    name: "Rain"
    unit_of_measurement: "in"
    value_template: "{{ value | round(4) }}"
    icon: "mdi:weather-rainy"
  - platform: mqtt
    state_topic: "weather/hourRain_in"
    name: "Hour Rain"
    unit_of_measurement: "in"
    value_template: "{{ value | round(4) }}"
    icon: "mdi:weather-rainy"
  - platform: mqtt
    state_topic: "weather/dayRain_in"
    name: "Day Rain"
    unit_of_measurement: "in"
    value_template: "{{ value | round(4) }}"
    icon: "mdi:weather-rainy"
  - platform: mqtt
    state_topic: "weather/rain24_in"
    name: "24 Hour Rain"
    unit_of_measurement: "in"
    value_template: "{{ value | round(4) }}"
    icon: "mdi:weather-rainy"
  - platform: mqtt
    state_topic: "weather/rain_total"
    name: "Rain Total"
    unit_of_measurement: "in"
    value_template: "{{ value | multiply(0.3937) | round(4) }}"
    icon: "mdi:weather-rainy"
  - platform: mqtt
    state_topic: "weather/dateTime"
    name: "WeeWX Timestamp"
    unit_of_measurement: "s"
    value_template: "{{ value }}"
```

I believe there are even more sensors values that can be used but these are the ones that were useful to me. If everything is working correctly when the Addon is running every couple minutes or so you should receive a "loop" message in the log tab that looks like this:

```
LOOP:   2021-04-02 13:56:17 EDT (1617386177) appTemp: 40.7389595009, channel: None, cloudbase: 8387.86618664, dateTime: 1617386177, dewpoint: 13.4533887788, heatindex: 47.5, humidex: 47.5, maxSolarRad: None, outHumidity: 25, outTemp: 47.5, outTempBatteryStatus: 0, rainRate: 0, rssi: 3, rxCheckPercent: 100.0, sensor_battery: 0, sensor_id: 1392, usUnits: 1, windchill: 47.5, windSpeed: 2.16448979085
REC:    2021-04-02 13:56:00 EDT (1617386160) altimeter: 30.5110888228, appTemp: 37.6812960635, barometer: 30.5393497982, channel: None, cloudbase: 8447.17015613, dateTime: 1617386160.0, dewpoint: 11.842451313, ET: None, heatindex: 46.15, humidex: 46.15, inTemp: 76.19, interval: 1, maxSolarRad: None, outHumidity: 24.5, outTemp: 46.15, outTempBatteryStatus: 0.0, pressure: 29.8123680055, rain: 0.0, rain_total: 6.5786, rainRate: 0.0, rssi: 3.0, rxCheckPercent: 100.0, sensor_battery: 0.0, sensor_id: 1392.0, usUnits: 1, windchill: 43.727635697, windDir: 225.0, windGust: 5.76509625064, windGustDir: None, windrun: 40.5201561234, windSpeed: 4.47916537214
LOOP:   2021-04-02 13:56:17 EDT (1617386177) dateTime: 1617386177, maxSolarRad: None, rainRate: 0, usUnits: 1
LOOP:   2021-04-02 13:56:35 EDT (1617386195) altimeter: 30.5110888228, channel: None, dateTime: 1617386195, inTemp: 76.19, maxSolarRad: None, outTempBatteryStatus: 0, pressure: 29.8123680055, rain: 0.0, rain_total: 6.5786, rainRate: 0, rssi: 3, rxCheckPercent: 100.0, sensor_battery: 0, sensor_id: 1392, usUnits: 1, windDir: 180.0, windSpeed: 1.65011743945
LOOP:   2021-04-02 13:56:54 EDT (1617386214) appTemp: 41.7713672246, channel: None, cloudbase: 7999.15719039, dateTime: 1617386214, dewpoint: 15.4637083623, heatindex: 47.8, humidex: 47.8, maxSolarRad: None, outHumidity: 27, outTemp: 47.8, outTempBatteryStatus: 0, rainRate: 0, rssi: 3, rxCheckPercent: 100.0, sensor_battery: 0, sensor_id: 1392, usUnits: 1, windchill: 47.8, windSpeed: 1.13574508805
```

This is what I use to determine the MQTT sensor names that are available to use.

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
