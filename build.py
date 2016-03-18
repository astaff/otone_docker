#!/usr/bin/env python3
import subprocess

repo='$REPO'
subprocess.call(
    "docker build -t common-$ARCH common/$ARCH && docker tag -f common-$ARCH common",
    shell=True)
subprocess.call(
    "docker save common | docker-squash -t common | docker load && docker tag -f common {0}/common-$ARCH && docker push {0}/common-$ARCH".format(repo),
    shell=True)
subprocess.call(
    "docker build -t {0} {0} && docker tag -f {0} {0}-$ARCH".format("common-build"),
    shell=True)
subprocess.call(
    "docker build -t {0} {0} && docker tag -f {0} {0}-$ARCH".format("bootstrap"),
    shell=True)
subprocess.call(
    "docker save {0}-$ARCH | docker-squash -t {1}/{0}-$ARCH:latest | docker load && docker push {1}/{0}-$ARCH:latest".format("bootstrap", repo),
    shell=True)

containers = ["crossbar", "frontend", "driver", "labware"]

for container in containers:
    subprocess.call(
        """docker build -t {0}-build {0} && docker run {0}-build > {0}/dist/root.tar.gz && docker build -t {0}-$ARCH {0}/dist""".format(container),
        shell=True)
    subprocess.call(
        "docker save {0}-$ARCH | docker-squash -t {1}/{0}-$ARCH:latest | docker load && docker push {1}/{0}-$ARCH:latest".format(container, repo),
        shell=True)
