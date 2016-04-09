#!/bin/bash

# exit on first error to avoid
# errors snowballing
set -o errexit

# Install AWS cli
pip install awscli

# each archtecture has it's own dockerfile
# we are linking it to common and later drop 
# the suffix to avoid boilerplate and parameterizing 
# docker files
sudo ln -fs $(pwd)/common-$ARCH $(pwd)/common

# prepare all common containers
for name in common common-build crossbar bootstrap
do
  docker build -t $REPO/$name-$ARCH $name/. \
  && docker tag $REPO/$name-$ARCH $name \
  && docker save $REPO/$name-$ARCH | gzip | aws s3 cp - s3://$AWS_BUCKET/builds/$name-$ARCH/$TRAVIS_BUILD_NUMBER/$REPO-$name-$ARCH.tar.gz \
  && aws s3 rm s3://$AWS_BUCKET/builds/$name-$ARCH/latest --recursive \
  && aws s3 cp s3://$AWS_BUCKET/builds/$name-$ARCH/$TRAVIS_BUILD_NUMBER s3://$AWS_BUCKET/builds/$name-$ARCH/latest/ --recursive
done