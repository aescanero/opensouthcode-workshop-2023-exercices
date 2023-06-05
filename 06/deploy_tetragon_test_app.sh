#!/bin/bash

kubectl create -f https://raw.githubusercontent.com/cilium/cilium/v1.11/examples/minikube/http-sw-app.yaml -n test
