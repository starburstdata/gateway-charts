#!/usr/bin/env sh
set -x
name=$(cat $1 | jq -r '.name')

echo "Activating backend: ${name}"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
host=$(yq '.spec.rules[0].host' ${SCRIPT_DIR}/../ingress-request.yaml)

curl -X POST https://${host}/gateway/backend/activate/${name}
