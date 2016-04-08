#!/bin/bash
pip install awscli

# each archtecture has it's own dockerfile
# we are linking it to common and later drop 
# the suffix to avoid boilerplate and parameterizing 
# docker files
sudo ln -fs $(pwd)/common-$ARCH $(pwd)/common

# this trick is done to allow compiling ARM images ander x86
# here we map arm executeable header to /usr/bin/qemu-arm-static
# handler that is located in common-arm container
# by doing this, we'll have arm environment in our container
# produced from common-arm
sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc  
sudo echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register  

# prepare all common containers
for name in common common-build crossbar bootstrap
do
  docker build -t $REPO/$name-$ARCH $name/. \
  && docker tag $REPO/$name-$ARCH $name \
  && docker save $REPO/$name-$ARCH | gzip | aws s3 cp - s3://$AWS_BUCKET/builds/$name-$ARCH/$TRAVIS_BUILD_NUMBER/$REPO-$name-$ARCH.tar.gz \
  && aws s3 rm s3://$AWS_BUCKET/builds/$name-$ARCH/latest --recursive \
  && aws s3 cp s3://$AWS_BUCKET/builds/$name-$ARCH/$TRAVIS_BUILD_NUMBER s3://$AWS_BUCKET/builds/$name-$ARCH/latest/ --recursive
done