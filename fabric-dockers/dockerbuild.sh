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
    or) ORDERERNAME="$OPTARG"
      ;;
    f) FABRIC="$OPTARG"
      ;;
    \?) echo "Invalid option -$OPTARG" >&2
     ;;
  esac
done
ORG_DOMAIN_NAME="$ORGNAME.$DOMAIN_NAME"
if [ "$FABRIC" = "cli" ] ; then
  
  IMAGE_NAME="cli-$PEERNAME-$ORG_DOMAIN_NAME"
  DOCKER_ARG="-e ORG_DOMAIN_NAME=$ORG_DOMAIN_NAME -e PEERNAME=$PEERNAME -e CORE_PEER_LOCALMSPID=$PEERMSP"

elif [ "$FABRIC" = "ca" ] ; then
  
  IMAGE_NAME=ca-$ORG_DOMAIN_NAME
  KEY_DIR="$WORKSPACE/network-config/crypto-config/peerOrganizations/$ORG_DOMAIN_NAME/ca"
  KEYNAME=$(find $KEY_DIR -type f -printf "%f\n" | grep _sk)
  DOCKER_ARG="-e ORG_DOMAIN_NAME=$ORG_DOMAIN_NAME -e KEYFILE_NAME=$KEYNAME"

elif [ "$FABRIC" = "orderer" ] ; then
  
  IMAGE_NAME=$ORDERERNAME-$DOMAIN_NAME
  DOCKER_ARG="-e DOMAIN_NAME=$DOMAIN_NAME -e ORDERERNAME=$ORDERERNAME"

elif [ "$FABRIC" = "peer" ] ; then
  
  IMAGE_NAME="$PEERNAME-$ORGNAME.$DOMAIN_NAME"
  DOCKER_ARG="-e ORG_DOMAIN_NAME=$ORGNAME.$DOMAIN_NAME -e PEER_NAME=$PEERNAME -e CORE_PEER_LOCALMSPID=$PEERMSP"
  
elif [ "$FABRIC" = "couchdb" ] ; then
  IMAGE_NAME="fabric-coucdb"
fi

if [ -z "$FABRIC" && -z "$DOCKER_ARG" ] ; then

 ehco "############## Building $FABRIC with argument \n $DOCKER_ARG ######################" 
 docker build $DOCKER_ARG -t shridharpatil01/$IMAGE_NAME:latest -f $FABRIC/Dockerfile

 ehco "############## Pushing $FABRIC with argument \n $DOCKER_ARG ######################" 
 docker push shridharpatil01/$IMAGE_NAME:latest

fi



