#!/usr/bin/env bash
docker build -e DOMAIN_NAME=$1 -e ORDERERNAME=$2 -t shridharpatil01/$2:latest .
docker push shridharpatil01/$2:latest
