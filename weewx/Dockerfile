ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apt-get update

RUN apt-get install -y sqlite3 wget sudo \
         python python3-pip python-cheetah python-pil python-usb python-setuptools \
         supervisor tzdata jq

RUN pip install configobj

RUN wget http://weewx.com/downloads/released_versions/weewx-3.9.1.tar.gz -O /tmp/weewx.tgz && \
      cd /tmp && \
      tar zxvf /tmp/weewx.tgz && \
      cd weewx-* ; ./setup.py build ; ./setup.py install --no-prompt

RUN wget https://github.com/eclipse/paho.mqtt.python/archive/v1.6.1.tar.gz -O /tmp/mqtt.tgz && \
      cd /tmp && \
      tar zxvf /tmp/mqtt.tgz && \
      cd paho.mqtt.python-* ; sudo python setup.py build ; sudo python setup.py install

RUN wget https://github.com/matthewwall/weewx-mqtt/archive/master.zip -O /tmp/weewx-mqtt.zip && \
      cd /tmp && \
      /home/weewx/bin/wee_extension --install weewx-mqtt.zip

# Copy data for add-on
COPY run.sh /
RUN chmod 777 /run.sh

CMD [ "/run.sh" ]
