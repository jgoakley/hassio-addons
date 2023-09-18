# Hass.io Add-ons for Home Assistant

## About

These Add-ons are a some pet projects I've been working on in my spare time. I may not be using some of the best practices for Home Assistant so if there's anything I can do to improve these feel free to create a comment, issue, or pull request.


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

This is what I use to determine the MQTT sensor names that are available to use. I believe the "loop" messages are sensor values that are being broadcast from the weather station to the display. I think these are broadcast at varying intervals based on how often specific sensors are updated. The "rec" values happen every 60 seconds and are WeeWX recording the values it has received to their destination, in this case publishing to MQTT.

### Issues with Weather Station USB Randomly Disconnecting

With KVM on Ubuntu I had an issue where every couple weeks or so KVM would stop passing the Weather Station USB device through to the VM. I couldn't figure out why it was happening so I added some automation to reattach the USB device when it disconnects.

#### Binary Sensor - Weather Station Connected (in Configuration.yaml)
```
binary_sensor:
  - platform: command_line
    name: Weather Station Connected
    command: "lsusb | grep 24c0:0003 | wc -l"
    payload_on: 1
    payload_off: 0
```

#### Shell Command - Detach/Reattach Weather Station (in Configuration.yaml)

For this to work you need to set up the ability for HomeAssistant to make SSH connections to your server. I used this guide to do that: https://siytek.com/home-assistant-shell/

```
shell_command:
  detach_weatherstation: ssh -i /config/ssh <your-user>@<your-linux-server-ip-address> -o 'StrictHostKeyChecking=no' "LIBVIRT_DEFAULT_URI=qemu:///system virsh detach-device <Home-Assistant-VM-Name> /home/<your-user>/weatherstation.xml"
  attach_weatherstation: ssh -i /config/ssh <your-user>@<your-linux-server-ip-address> -o 'StrictHostKeyChecking=no' "LIBVIRT_DEFAULT_URI=qemu:///system virsh attach-device <Home-Assistant-VM-Name> /home/<your-user>/weatherstation.xml"
```

#### weatherstation.xml (on Linux computer running KVM - I stored mine in my user's home directory)

You may have to change the bus and port number to match
```
<hostdev mode="subsystem" type="usb" managed="yes">
  <source>
    <vendor id="0x24c0"/>
    <product id="0x0003"/>
  </source>
  <alias name="hostdev0"/>
  <address type="usb" bus="0" port="5"/>
</hostdev>
```

#### Automation YAML
```
alias: Reattach Weather Station
description: ''
trigger:
  - platform: state
    entity_id: binary_sensor.weather_station_connected
    to: 'off'
  - platform: time_pattern
    seconds: '0'
condition:
  - condition: state
    entity_id: binary_sensor.weather_station_connected
    state: 'off'
action:
  - service: shell_command.detach_weatherstation
  - delay:
      hours: 0
      minutes: 0
      seconds: 5
      milliseconds: 0
  - service: shell_command.attach_weatherstation
  - delay:
      hours: 0
      minutes: 0
      seconds: 5
      milliseconds: 0
  - service: hassio.addon_restart
    data:
      addon: 10409bfc_hassio_weewx
mode: single
```

## Hassception
This addon lets you run Home Assistant inside Home Assistant! Home Assistant Inception!

If you are running Home Assistant OS this addon will create an entirely new Home Assistant core instance that runs alongside your existing instance.

By default the new instance will be available at <your_ha_address>:8124 but the port can be updated in the configuration tab.

#### Current Issues:

##### You will need to create a ```hassception``` folder in your ```config``` directory which is where your new instance configuration will be stored


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
