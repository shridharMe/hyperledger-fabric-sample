#!/usr/bin/env bash

set -e
while getopts "o:p:m:or:f:" opt; do
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

if [ -z $WORKSPACE ] ; then
   $WORKSPACE=`pwd`
fi
export ORG_DOMAIN_NAME="$ORGNAME.$DOMAIN_NAME"
export PEERNAME=$PEERNAME 
export CORE_PEER_LOCALMSPID=$PEERMSP
export ORDERERNAME=$ORDERERNAME
export DOMAIN_NAME=$DOMAIN_NAME


if [ "$FABRIC" == "cli" ] ; then  
  
  if [ -z $ORGNAME ] || [ -z $PEERNAME ] || [ -z $PEERMSP ] ; then
   echo "required values are missing; please pass org,peer and msp values"
   exit 0;
  fi

  IMAGE_NAME="fabric-cli-$PEERNAME-$ORG_DOMAIN_NAME" 

elif [ "$FABRIC" == "ca" ] ; then
  IMAGE_NAME="fabric-ca-$ORG_DOMAIN_NAME"
  KEY_DIR="$WORKSPACE/network-config/crypto-config/peerOrganizations/$ORG_DOMAIN_NAME/ca"
  KEYNAME=$(find $KEY_DIR -type f -printf "%f\n" | grep _sk)
  export KEYFILE_NAME=$KEYNAME
elif [ "$FABRIC" == "orderer" ] ; then
  IMAGE_NAME="fabric-$ORDERERNAME-$DOMAIN_NAME"
elif [ "$FABRIC" == "peer" ] ; then
  IMAGE_NAME="fabric-$PEERNAME-$ORGNAME.$DOMAIN_NAME" 
elif [ "$FABRIC" == "couchdb" ] ; then
  IMAGE_NAME="fabric-couchdb"
else
  echo "invalid fabric value; only valid values are peer,cli,ca,orderer or couchdb"
  exit 0;
fi


if [ ! -z "$FABRIC" ] && [ ! -z "$IMAGE_NAME" ] ; then

 echo "--------- Building $FABRIC -----------------------" 
 docker build \
 --build-arg ORG_DOMAIN_NAME  \
 --build-arg PEERNAME  \
 --build-arg CORE_PEER_LOCALMSPID  \
 --build-arg ORDERERNAME  \
 --build-arg DOMAIN_NAME  \
 -t shridharpatil01/$IMAGE_NAME:latest -f $FABRIC/Dockerfile

echo "--------- Pushing $FABRIC -----------------------" 
 docker push shridharpatil01/$IMAGE_NAME:latest
else
 echo "nothing to do for me"
fi



