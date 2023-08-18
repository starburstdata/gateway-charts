#!/usr/bin/env sh
host=$(yq '.spec.rules[1].host' ingress.yaml)
curl -X GET https://${host}/entity/GATEWAY_BACKEND | jq