FROM hyperledger/fabric-peer:latest

WORKDIR /opt/gopath/src/github.com/hyperledger/fabric/peer

ARG ORG_DOMAIN_NAME=org1.example.com
ARG PEER_NAME=peer0
ENV CORE_PEER_LOCALMSPID=Org1MSP

ENV CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock
ENV CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=bridge

ENV CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/$ORG_DOMAIN_NAME/users/Admin@$ORG_DOMAIN_NAME/msp
ENV CORE_PEER_ID=$PEER_NAME.$ORG_DOMAIN_NAME
ENV CORE_PEER_ADDRESS=$PEER_NAME.$ORG_DOMAIN_NAME:7051
ENV CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:7052
ENV CORE_PEER_GOSSIP_EXTERNALENDPOINT=$PEER_NAME.$ORG_DOMAIN_NAME:7051


ENV CORE_PEER_TLS_ENABLED=true
ENV CORE_PEER_GOSSIP_USELEADERELECTION=true
ENV CORE_PEER_GOSSIP_ORGLEADER=false
ENV CORE_PEER_PROFILE_ENABLED=true
ENV CORE_PEER_TLS_CERT_FILE=/etc/hyperledger/fabric/tls/server.crt
ENV CORE_PEER_TLS_KEY_FILE=/etc/hyperledger/fabric/tls/server.key
ENV CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/tls/ca.crt

ENV CORE_LEDGER_STATE_STATEDATABASE=CouchDB
ENV CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=$PEER_NAME.$ORG_DOMAIN_NAME:5984
ENV CORE_LEDGER_STATE_COUCHDBCONFIG_USERNAME=peeradmin
ENV CORE_LEDGER_STATE_COUCHDBCONFIG_PASSWORD=peeradmin

ENV CORE_LOGGING_LEVEL=DEBUG

COPY ./network-config/crypto-config/peerOrganizations/$ORG_DOMAIN_NAME/peers/$PEER_NAME.$ORG_DOMAIN_NAME/msp /etc/hyperledger/fabric/msp
COPY ./network-config/crypto-config/peerOrganizations/$ORG_DOMAIN_NAME/peers/$PEER_NAME.$ORG_DOMAIN_NAME/tls /etc/hyperledger/fabric/tls
COPY ./network-config/crypto-config /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/
COPY ./network-config/channel-artifacts /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts

EXPOSE 7051 7052 7053
CMD  ["peer" , "node" , "start"]
