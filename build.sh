#!/bin/bash
pip install awscli
ln -fs $(pwd)/common-$ARCH $(pwd)/common
for name in common common-build crossbar bootstrap
do
  docker build -t $REPO/$name-$ARCH $name/. \
  && docker save $REPO/$name-$ARCH | gzip | aws s3 cp - s3://$AWS_BUCKET/builds/$name-$ARCH/$TRAVIS_BUILD_NUMBER/$REPO-$name-$ARCH.tar.gz \
  && aws s3 rm s3://$AWS_BUCKET/builds/$name-$ARCH/latest --recursive \
  && aws s3 cp s3://$AWS_BUCKET/builds/$name-$ARCH/$TRAVIS_BUILD_NUMBER s3://$AWS_BUCKET/builds/$name-$ARCH/latest/ --recursive
done