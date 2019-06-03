#!/usr/bin/env bash

# Purpose: Create the artifcats for the Hyperledger fabric.
## @author : shridhar.patil01@googlemail.com


if [ -z "$WORKSPACE" ] ; then
WORKSPACE=`pwd`
fi

printf " **** \n **** you are working in $WORKSPACE **** \n **** \n"

PROJECT_BASE=$WORKSPACE/network-config/chaincode
NETWORK_DIR=/$WORKSPACE/network-config
FABRIC_CFG_PATH=$WORKSPACE/network-config
CHANNEL_ARTIFACTS=$WORKSPACE/network-config/channel-artifacts
CRYPTO_CONFIG=$WORKSPACE/network-config/crypto-config
FABRIC_VERSION='1.4'
CHANNEL_NAME='mychannel'

doSetupVars() {
  echo ++ Setup Vars: `pwd`
  if [ ! -f "$HOME/.scriptVars" ]
  then
    touch "$HOME/.scriptVars"
    echo ". \"$HOME/.scriptVars\"" >> ~/.profile
  fi
  if [ -f "$HOME/.scriptVars" ]
  then
    truncate -s 0 ~/.scriptVars
  fi
  if [ -z ${PROJECT_BASE+x} ]; then echo "PROJECT_BASE is unset" && exit 1; else echo "PROJECT_BASE is set to '$PROJECT_BASE'" && echo export PROJECT_BASE=\""$PROJECT_BASE"\" >> ~/.scriptVars; fi
  if [ -z ${NETWORK_DIR+x} ]; then echo "NETWORK_DIR is unset" && exit 1; else echo "NETWORK_DIR is set to '$NETWORK_DIR'" && echo  export NETWORK_DIR=\""$NETWORK_DIR"\" >> ~/.scriptVars; fi
  if [ -z ${FABRIC_CFG_PATH+x} ]; then echo "FABRIC_CFG_PATH is unset" && exit 1; else echo "FABRIC_CFG_PATH is set to '$FABRIC_CFG_PATH'" && echo export FABRIC_CFG_PATH=\""$FABRIC_CFG_PATH"\" >> ~/.scriptVars; fi
  if [ -z ${CHANNEL_ARTIFACTS+x} ]; then echo "CHANNEL_ARTIFACTS is unset" && exit 1; else echo "CHANNEL_ARTIFACTS is set to '$CHANNEL_ARTIFACTS'" && echo export CHANNEL_ARTIFACTS=\""$CHANNEL_ARTIFACTS"\" >> ~/.scriptVars; fi
  if [ -z ${CRYPTO_CONFIG+x} ]; then echo "CRYPTO_CONFIG is unset" && exit 1; else echo "CRYPTO_CONFIG is set to '$CRYPTO_CONFIG'" && echo export CRYPTO_CONFIG=\""$CRYPTO_CONFIG"\" >> ~/.scriptVars; fi
  if [ -z ${CHANNEL_NAME+x} ]; then echo "CHANNEL_NAME is unset" && exit 1; else echo "CHANNEL_NAME is set to '$CHANNEL_NAME'" && echo export CHANNEL_NAME="\"$CHANNEL_NAME\"" >> ~/.scriptVars; fi
  if [ -z ${FABRIC_VERSION+x} ]; then echo "FABRIC_VERSION is unset" && exit 1; else echo "FABRIC_VERSION is set to '$FABRIC_VERSION'" && echo export FABRIC_VERSION=\""$FABRIC_VERSION"\" >> ~/.scriptVars; fi
  PATH=$PATH:$WORKSPACE/bin >> ~/.scriptVars;

  source ~/.profile
}
doGenerateArtifacts() {
  #Generating the artefacts
  echo ++ Generating Artifacts: `pwd`
  cd "$FABRIC_CFG_PATH"

  #channel artifacts
  rm -rf "$CRYPTO_CONFIG"
  mkdir "$CRYPTO_CONFIG"
  cryptogen generate --config=$NETWORK_DIR/crypto-config.yaml

  #channel artifacts
  rm -rf "$CHANNEL_ARTIFACTS"
  mkdir "$CHANNEL_ARTIFACTS"
  configtxgen -profile FourOrgsOrdererGenesis -outputBlock "$CHANNEL_ARTIFACTS"/genesis.block

  #channel name
  configtxgen -profile FourOrgsChannel -outputCreateChannelTx "$CHANNEL_ARTIFACTS"/channel.tx -channelID "$CHANNEL_NAME"

  #generate anchor peer
  configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID "$CHANNEL_NAME" -asOrg Org1MSP
  configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID "$CHANNEL_NAME" -asOrg Org2MSP
  configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID "$CHANNEL_NAME" -asOrg Org3MSP
  configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPanchors.tx -channelID "$CHANNEL_NAME" -asOrg Org4MSP   
}


printf " ****\n **** parsing configtx file **** \n ****\n"


doSetupVars
doGenerateArtifacts
 