#
# Bootstrap OT.one
# - install docker-compose
# - run compose script
#
# map docker socket file from host machine to allow for containers to be created on host:
# docker run -v /var/run/docker.sock:/var/run/docker.sock bootstrap 
#
# TODO: 
# - add ser2net 
# - initialize pins
# - link host's serial port
#
FROM common

RUN apk update \
    && apk add \
    wget \
    ca-certificates \
    && wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3 \
    && pip install docker-compose

COPY docker-compose.yml docker-compose.yml
WORKDIR /home

RUN apk del wget ca-certificates && rm -rf /var/cache/apk/*

ENTRYPOINT ["docker-compose", "up"]
