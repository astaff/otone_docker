#!/bin/sh
docker tag bootstrap-$ARCH astaff/otone-bootstrap-$ARCH && \
docker tag crossbar-$ARCH astaff/otone-crossbar-$ARCH && \
docker tag driver-$ARCH astaff/otone-driver-$ARCH && \
docker tag frontend-$ARCH astaff/otone-frontend-$ARCH && \
docker tag labware-$ARCH astaff/otone-labware-$ARCH && \
docker push astaff/otone-bootstrap-$ARCH && \
docker push astaff/otone-crossbar-$ARCH && \
docker push astaff/otone-driver-$ARCH && \
docker push astaff/otone-frontend-$ARCH && \
docker push astaff/otone-labware-$ARCH