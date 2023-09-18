ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN echo "hello there"

RUN bash -c 'mkdir -p /config/hassception'

CMD mkdir -p /config/hassception && python -m homeassistant --config /config/hassception