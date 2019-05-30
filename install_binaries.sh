#!/bin/bash

wget https://raw.githubusercontent.com/hyperledger/fabric/master/scripts/bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh -d -s
rm bootstrap.sh
