# Prerequisites
Docker 1.9 is required (1.10 introduced breaking chages that affect the ability to squash images)

Install docker-squash (https://github.com/jwilder/docker-squash):
```
wget https://github.com/jwilder/docker-squash/releases/download/v0.2.0/docker-squash-linux-amd64-v0.2.0.tar.gz
sudo tar -C /usr/local/bin -xzvf docker-squash-linux-amd64-v0.2.0.tar.gz
```

ARM: Please visit http://blog.hypriot.com/downloads/ and download latest Raspbian image with Docker and update docker with 1.9 package (```dpkg -i package_name.deb```). Latest docker for ARM: https://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb.

x86: Tested on Digital Ocean using Ubuntu 14.04 + Docker 1.9.1. 

# Description
This is the suite of Docker containers to run OT.one software in a nice modular fashion.

Builds are being made in -build containers derived from common-build. After build is complete, it's output is piped out as tar.gz2 which should be stored and copied into a smaller container as one layer for efficient distribution. 

Common packages are installed into *common*. arm and x86 sub-folders contain different base images for arm and x86 respectively. 

Both ARM and x86 images can be built on x86 host (DigitalOcean machine, for instance). Building ARM images on x86 host is achieved by installing qemu into otone-common-arm and mapping ELF ARM header to /usr/bin/qemu-arm-static binary installed in the container. In order to build new ARM images on x86 from otone-common-arm, run the folloing on build machine once:

```
mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc  
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register  
```
# Bootstrap
Bootsrap currently contains docker-compose and docker-compose.xml that links everything together. In the future it could also contain all GPIO initialization scripts and ser2net. 

**IMPORTANT:** while running bootstrap you should map ```/var/run/docker.sock``` from container to host. This way docker-compose will create containers on a host machine, not inside a container. Example ```docker run -v /var/run/docker.sock:/var/run/docker.sock bootstrap```

# Building / Pushing
```ARCH=arm REPO=opentrons ./build.sh``` — you can replace arm with x86. Repo is the name of docker hub repository to commit to.

# Running
```ARCH=arm REPO=opentrons ./run.sh``` — you can replace arm with x86. Repo is the name of docker hub repository to read from.

# Testing
Define otone.local host in /etc/hosts to point to your Raspberry Pi or build machine in the cloud. Access
