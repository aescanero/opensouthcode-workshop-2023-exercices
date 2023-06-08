#!/bin/bash

REVISAR: kube-prometheus-stack-grafana

STACKROX_ADMIN_PASSWORD="$(openssl rand -base64 20 | tr -d '/=+')"

helm upgrade -n stackrox stackrox-central-services stackrox/stackrox-central-services \
--install \
--create-namespace \
--set central.resources.requests.memory=1Gi \
--set central.resources.requests.cpu=1 \
--set central.resources.limits.memory=4Gi \
--set central.resources.limits.cpu=1 \
--set central.db.resources.requests.memory=1Gi \
--set central.db.resources.requests.cpu=500m \
--set central.db.resources.limits.memory=4Gi \
--set central.db.resources.limits.cpu=1 \
--set scanner.autoscaling.disable=true \
--set scanner.replicas=1 \
--set scanner.resources.requests.memory=500Mi \
--set scanner.resources.requests.cpu=500m \
--set scanner.resources.limits.memory=2500Mi \
--set scanner.resources.limits.cpu=2000m \
--set central.adminPassword.value="${STACKROX_ADMIN_PASSWORD}"

kubectl -n stackrox exec deploy/central -- roxctl --insecure-skip-tls-verify \
--password "${STACKROX_ADMIN_PASSWORD}" \
central init-bundles generate stackrox-init-bundle --output - > stackrox-init-bundle.yaml

CLUSTER_NAME="my-secured-cluster"

helm install -n stackrox stackrox-secured-cluster-services stackrox/stackrox-secured-cluster-services \
-f stackrox-init-bundle.yaml \
--set clusterName="$CLUSTER_NAME" \
--set sensor.resources.requests.memory=500Mi \
--set sensor.resources.requests.cpu=500m \
--set sensor.resources.limits.memory=500Mi \
--set sensor.resources.limits.cpu=500m
