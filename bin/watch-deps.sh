#!/bin/bash

ORG=$1
SCRIPT=${2:-watch}

if [[ -z "$ORG" ]]; then
  echo "usage: watch-deps organization [script]"
  exit 1
fi

cd node_modules/$ORG
echo "watch-deps: $ORG"

run_string=''
for org_package in */ ; do
  if [ -L ${org_package} ] && [ -e ${org_package} ]; then
    # watch only applies for linked packages
    cd $org_package
    yarn $SCRIPT &
    cd ..
  fi
done
wait