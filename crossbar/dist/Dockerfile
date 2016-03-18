#
# Crossbar in a central part of container communication in OT.one
#
# FROM astaff/otone-common-arm:latest
FROM common

WORKDIR /home
COPY root.tar.gz root.tar.gz
RUN apk update && apk add libsodium && tar -xvzf root.tar.gz -C / && rm root.tar.gz

EXPOSE 8080
RUN rm -rf /var/cache/apk/*

# You need to forward port 8080 with "-p 8080" on the command-line:
# docker run -p 8080 crossbar
ENTRYPOINT ["crossbar", "start", "--cbdir", ".crossbar"]
