#!/bin/bash
# Expected environment variables
# 
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
# AWS_BUCKET
# REPO
# ARCH
#
# exit on first error to avoid
# errors snowballing
set -o errexit

apt-get install -y sharutils
# Install AWS cli
pip install awscli

rm -rf otone-dist

for n in common bootstrap sandbox-frontend sandbox-driver
do
  aws s3 cp s3://$AWS_BUCKET/builds/$n-$ARCH/latest/$REPO-$n-$ARCH.tar.gz otone-dist/
done

tar -cvf otone-dist.tar otone-dist/*
rm -rf otone-dist
rm -f otone-install.sh
touch otone-install.sh
echo "ARCH=$ARCH" >> otone-install.sh
echo "REPO=$REPO" >> otone-install.sh
cat install.sh >> otone-install.sh
uuencode otone-dist.tar /dev/stdout >> otone-install.sh
rm -f otone-dist.tar
chmod +x otone-install.sh