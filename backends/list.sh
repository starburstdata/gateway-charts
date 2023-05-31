#!/usr/bin/env sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
host=$(yq '.spec.rules[0].host' ${SCRIPT_DIR}/../ingress-request.yaml)
curl -X GET https://${host}/entity/GATEWAY_BACKEND | jq