ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN bash -c 'mkdir -p /config/hassception'

CMD [ "python", "-m", "homeassistant", "--config", "/config/hassception" ]