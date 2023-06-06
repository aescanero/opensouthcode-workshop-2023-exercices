#!/bin/bash

USER=$(kubectl oidc_login setup --oidc-issuer-irl=https://manager.workshop:5554/dex --oidc-client-id=kubernetes --oidc-client-secret=aGVsbG9fZnJpZW5kCg== 2>&1|grep sub|cut -d\" -f 3)
kubectl create clusterrolebinding oidc-cluster-admin --clusterrole=cluster-admin --user='https://manager.workshop:5554/dex#'${USER}
kubectl config set-credentials oidc \
	  --exec-api-version=client.authentication.k8s.io/v1beta1 \
	  --exec-command=kubectl \
	  --exec-arg=oidc-login \
	  --exec-arg=get-token \
	  --exec-arg=--oidc-issuer-url=https://manager.workshop:5554/dex \
	  --exec-arg=--oidc-client-id=kubernetes \
	  --exec-arg=--oidc-client-secret=aGVsbG9fZnJpZW5kCg==
kubectl --user=oidc get nodes
kubectl config set-context --current --user=oidc

