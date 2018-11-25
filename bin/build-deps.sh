#!/bin/bash

ORG=$1
LOGDIR=`pwd`;
LOGFILE=$LOGDIR/build-deps.log
SCRIPT=${2:-build}

cd node_modules/$ORG
echo "builddeps: $ORG"
echo "output: build-deps.log"
exec &> $LOGFILE

for org_package in */ ; do
  # do not process symlinks
  if ! [ -L ${org_package} ]; then
    cd $org_package
    echo "-- processing dependency: $org_package --"
    yarn && yarn $SCRIPT
    # clear internal node_modules after build
    rm -rf node_modules
    cd ..
    echo "-- complete --"
  fi
done
