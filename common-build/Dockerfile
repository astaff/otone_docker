# 
# Common dependencies for building OT.one containers
#
FROM common

RUN apk update && apk add \
    build-base \ 
    ca-certificates \
    libffi-dev \ 
    python3 \
    python3-dev \
    wget \ 
    && wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3

WORKDIR /home