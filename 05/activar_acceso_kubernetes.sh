#!/bin/bash

mkdir ~/.kube

export KUBECONFIG=~/.kube/config

cat >~/.kube/config <<EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: $(cat /var/lib/rancher/k3s/server/tls/server-ca.crt | base64 -w0)
    server: https://127.0.0.1:6443
  name: default
contexts:
- context:
    cluster: default
    user: oidc
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: oidc
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - oidc-login
      - get-token
      - --oidc-issuer-url=https://manager.workshop:5554/dex
      - --oidc-client-id=kubernetes
      - --oidc-extra-scope=email
      - --oidc-client-secret=aGVsbG9fZnJpZW5kCg==
      command: kubectl
      env: null
      provideClusterInfo: false
EOF

