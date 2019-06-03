#!/usr/bin/env bash

set -e
while getopts "o:" opt; do
   case $opt in
    o) ORGNAME="$OPTARG"
      ;;
     \?) echo "Invalid option -$OPTARG" >&2
     ;;
  esac
done

ORG_DOMAIN_NAME=$ORGNAME.$DOMAIN_NAME
IMAGE_NAME=ca-$ORG_DOMAIN_NAME

KEY_DIR="$WORKSPACE/network-config/crypto-config/peerOrganizations/$ORG_DOMAIN_NAME/ca"
KEYNAME=$(find $KEY_DIR -type f -printf "%f\n" | grep _sk)

docker build -e ORG_DOMAIN_NAME=$ORG_DOMAIN_NAME -e KEYFILE_NAME=$KEYNAME  -t shridharpatil01/$IMAGE_NAME:latest .
docker push shridharpatil01/$IMAGE_NAME:latest