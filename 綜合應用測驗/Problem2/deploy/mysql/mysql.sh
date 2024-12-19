#!/usr/bin/env bash

helm upgrade --install poc-mysql bitnami/mysql \
    --namespace asiayo \
    --create-namespace \
    -f values.yaml
