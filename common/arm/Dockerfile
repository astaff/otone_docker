# 
# Common dependencies for OT.one
#

# for ARM use this
FROM vimagick/alpine-arm:3.3
# for x86 use this
# FROM gliderlabs/alpine:3.3

# for ARM uncomment this and run this on the host machine:
# mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc  
# echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register  
COPY qemu-arm-static /usr/bin/qemu-arm-static

RUN apk update && \
    apk add \
    ca-certificates \
    python3 \
    wget

RUN apk del wget ca-certificates && rm -rf /var/cache/apk/*

WORKDIR /home
