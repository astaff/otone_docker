#!/bin/sh
docker pull $REPO/bootstrap-$ARCH && docker tag -f $REPO/bootstrap-$ARCH bootstrap && \
docker pull $REPO/crossbar-$ARCH && docker tag -f $REPO/crossbar-$ARCH crossbar && \
docker pull $REPO/driver-$ARCH && docker tag -f $REPO/driver-$ARCH driver && \
docker pull $REPO/frontend-$ARCH && docker tag -f $REPO/frontend-$ARCH frontend && \
docker pull $REPO/labware-$ARCH && docker tag -f $REPO/labware-$ARCH labware && \
docker run -v /var/run/docker.sock:/var/run/docker.sock bootstrap 
