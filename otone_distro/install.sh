#!/bin/bash

set -o errexit

rm -rf otone-dist
uudecode $0 | tar -xv
for n in common bootstrap sandbox-frontend sandbox-driver
do
  docker rmi -f $REPO/$n-$ARCH
  docker rmi -f $n
  cat otone-dist/$REPO-$n-$ARCH.tar.gz | gunzip | docker load && docker tag -f $REPO/$n-$ARCH $n
done

rm -rf otone-dist
exit
