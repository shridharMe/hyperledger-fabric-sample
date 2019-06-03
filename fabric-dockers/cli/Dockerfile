FROM hyperledger/fabric-tools:latest
WORKDIR /opt/gopath/src/github.com/hyperledger/fabric/peer

ARG ORG_DOMAIN_NAME=org1.example.com
ARG PEER_NAME=peer0
ENV CORE_PEER_LOCALMSPID=Org1MSP

ENV GOPATH=/opt/gopath
ENV CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock
ENV CORE_LOGGING_LEVEL=DEBUG
ENV CORE_PEER_ID=cli
ENV CORE_PEER_ADDRESS=$PEER_NAME.$ORG_DOMAIN_NAME:7051
ENV CORE_PEER_CHAINCODELISTENADDRESS=$PEER_NAME.$ORG_DOMAIN_NAME:7052


ENV CORE_PEER_TLS_ENABLED=true
ENV CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/$ORG_DOMAIN_NAME/peers/$PEER_NAME.$ORG_DOMAIN_NAME/tls/server.crt
ENV CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/$ORG_DOMAIN_NAME/peers/$PEER_NAME.$ORG_DOMAIN_NAME/tls/server.key
ENV CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/$ORG_DOMAIN_NAME/peers/$PEER_NAME.$ORG_DOMAIN_NAME/tls/ca.crt
ENV CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/$ORG_DOMAIN_NAME/users/Admin@$ORG_DOMAIN_NAME/msp
ENV CHAIN_CODE_PATH=/opt/gopath/src/github.com/chaincode/
ENV CHAIN_CODE_VERSION="1.0"
ENV CHAIN_CODE_NAME="mycc"


COPY  /var/run/ /host/var/run/
COPY ./network-config/chaincode/ /opt/gopath/src/github.com/chaincode
COPY ./network-config/crypto-config /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/
COPY ./network-config/channel-artifacts /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts

CMD ["/bin/bash"]
