FROM hyperledger/fabric-ca:latest

ARG ORG_DOMAIN_NAME=org1.example.com
ARG KEYFILE_NAME=#KEYFILENAME#


ENV FABRIC_CA_SERVER_CA_NAME=ca.$ORG_DOMAIN_NAME
ENV FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server

ENV FABRIC_CA_SERVER_CA_CERTFILE=/etc/hyperledger/fabric-ca-server-config/ca.$ORG_DOMAIN_NAME-cert.pem
ENV FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/$KEYFILE_NAME

ENV FABRIC_CA_SERVER_TLS_ENABLED=true
ENV FABRIC_CA_SERVER_TLS_CERTFILE=/etc/hyperledger/fabric-ca-server-config/ca.$ORG_DOMAIN_NAME-cert.pem
ENV FABRIC_CA_SERVER_TLS_KEYFILE=/etc/hyperledger/fabric-ca-server-config/$KEYFILE_NAME

COPY ./network-config/crypto-config/peerOrganizations/$ORG_DOMAIN_NAME/ca/ /etc/hyperledger/fabric-ca-server-config
COPY ./fabric-ca-server-config.yaml /etc/hyperledger/fabric-ca-server/fabric-ca-server-config.yaml

RUN ls -lrt  /etc/hyperledger/fabric-ca-server-config/

EXPOSE 7054

CMD ["sh", "-c" , "fabric-ca-server start -b admin:adminpw -d"]
