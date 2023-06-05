#!/bin/sh

docker image save -o tmp/demo localhost/demo:01
./trivy image --security-checks vuln --offline-scan -f json -s CRITICAL --timeout 5m0s --input tmp/demo
