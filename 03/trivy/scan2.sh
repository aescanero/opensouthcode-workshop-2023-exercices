#!/bin/sh

docker pull docker.io/nginx:latest
docker image save  -o tmp/nginx docker.io/nginx:latest
./trivy image -s CRITICAL --timeout 5m0s --input tmp/nginx
