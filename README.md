# Prerequisites
Docker 1.10 is required

ARM: Please visit [http://blog.hypriot.com/downloads/] and download latest Raspbian image with Docker and update docker with 1.10 package (```dpkg -i package_name.deb```). Latest docker for ARM: [https://downloads.hypriot.com/docker-hypriot_1.10.2-1_armhf.deb].

x86: Tested on Digital Ocean using Ubuntu 14.04 + Docker droplet. 

# Descirption
This is the suite of Docker containers to run OT.one software in a nice modular fashion.

Common packages are installed into *common*. arm and x86 sub-folders contain different base images for arm and x86 respectively. 

Both ARM and x86 images (except for common/arm) can be built on x86 host (DigitalOcean machine, for instance). In order to do that, run ```docker pull astaff/otone-common-arm && docker tag astaff/otone-common-arm common```. This will set a pre-built ARM base image for the rest of the rest of ARM images that will be built on x86 host.

Building ARM images on x86 host is achieved by installing qemu into otone-common-arm and mapping ELF ARM header to /usr/bin/qemu-arm-static binary installed in the container. In order to build new ARM images on x86 from otone-common-arm, run the folloing on build machine once:

```
mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc  
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register  
```

**IMPORTANT:** *common/arm* should be built on a physical ARM machine (RasPi or BBB). The reason for that is a segfault in QEMU 2.5 when running ruby/gem required for frontend. This is likely due to multicore support issues in QEMU. At the moment it seems impractical to ivestigate that as base ARM image is unlikely to be changed frequently and takes about 30 minutes to build on Raspberry Pi 2. 

# Bootstrap
Bootsrap currently contains docker-compose and docker-compose.xml that links everything together. In the future it could also contain all GPIO initialization scripts and ser2net. 

**IMPORTANT:** while running bootstrap you should map ```/var/run/docker.sock``` from container to host. This way docker-compose will create containers on a host machine, not inside a container. Example ```docker run -v /var/run/docker.sock:/var/run/docker.sock bootstrap```

# Building
```ARCH=arm ./build.sh``` — you can replace arm with x86
You can also publish into Docker Hub by running ```ARCH=arm ./publish.sh```

# Running
```ARCH=arm ./run.sh``` — you can replace arm with x86

# Testing
Define otone.local host in /etc/hosts to point to your Raspberry Pi or build machine in the cloud. Access
