#!/usr/bin/env bash

set -e
while getopts "o:p:m:" opt; do
   case $opt in
    o) ORGNAME="$OPTARG"
      ;;
    p) PEERNAME="$OPTARG"
      ;;
    m) PEERMSP="$OPTARG"
      ;;
    \?) echo "Invalid option -$OPTARG" >&2
     ;;
  esac
done

ORG_DOMAIN_NAME="$ORGNAME.$DOMAIN_NAME"
IMAGE_NAME="cli-$PEERNAME-$ORG_DOMAIN_NAME"

docker build -e ORG_DOMAIN_NAME=$ORG_DOMAIN_NAME -e PEERNAME=$PEERNAME -e CORE_PEER_LOCALMSPID=$PEERMSP -t shridharpatil01/$IMAGE_NAME:latest .
docker push shridharpatil01/$IMAGE_NAME:latest