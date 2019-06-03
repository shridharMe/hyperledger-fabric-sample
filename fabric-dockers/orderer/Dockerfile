FROM hyperledger/fabric-orderer:latest
WORKDIR /opt/gopath/src/github.com/hyperledger/fabric

ARG DOMAIN_NAME=example.com
ARG ORDERERNAME=orderer
ARG ORDERER_HOSTNAME=$ORDERERNAME.$DOMAIN_NAME


ENV ORDERER_GENERAL_LOGLEVEL=debug
ENV ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
ENV ORDERER_GENERAL_GENESISMETHOD=file
ENV ORDERER_GENERAL_GENESISFILE=/var/hyperledger/orderer/orderer.genesis.block
ENV ORDERER_GENERAL_LOCALMSPID=OrdererMSP
ENV ORDERER_GENERAL_LOCALMSPDIR=/var/hyperledger/orderer/msp

ENV ORDERER_GENERAL_TLS_ENABLED=true
ENV ORDERER_GENERAL_TLS_PRIVATEKEY=/var/hyperledger/orderer/tls/server.key
ENV ORDERER_GENERAL_TLS_CERTIFICATE=/var/hyperledger/orderer/tls/server.crt
ENV ORDERER_GENERAL_TLS_ROOTCAS=[/var/hyperledger/orderer/tls/ca.crt]

COPY ./network-config/channel-artifacts/genesis.block /var/hyperledger/orderer/orderer.genesis.block
COPY ./network-config/crypto-config/ordererOrganizations/$DOMAIN_NAME/orderers/$ORDERER_HOSTNAME/msp /var/hyperledger/orderer/msp
COPY ./network-config/crypto-config/ordererOrganizations/$DOMAIN_NAME/orderers/$ORDERER_HOSTNAME/tls/ /var/hyperledger/orderer/tls

EXPOSE 7050

CMD ["orderer"]