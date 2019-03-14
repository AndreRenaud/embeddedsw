#!/bin/sh
# Utility script to build the docker development environment,
# and then launch it with the current directory mounted inside.
set -e -x
docker build -t embeddedsw .
docker run -ti -v `pwd`:`pwd` -w `pwd` -u `id -u`:`id -g` embeddedsw
