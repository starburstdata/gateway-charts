#!/usr/bin/env sh
name=$(cat $1 | jq -r '.name')

echo "Removing backend: ${name}"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
host=$(yq '.spec.rules[0].host' ${SCRIPT_DIR}/../ingress-request.yaml)

curl -X POST -d "${name}" https://${host}/gateway/backend/modify/delete
