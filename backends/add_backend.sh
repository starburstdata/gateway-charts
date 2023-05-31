#!/usr/bin/env sh
set -x
FILE=$1
name=$(cat $FILE | jq -r '.name')
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
host=$(yq '.spec.rules[0].host' ${SCRIPT_DIR}/../ingress-request.yaml)

if [ -z $(curl -X GET https://${host}/gateway/backend/active 2>/dev/null | jq -r '.[].name' | grep -x "${name}") ]; then
  curl -H "Content-Type: application/json" -X POST https://${host}/gateway/backend/modify/add -d @${FILE}
  echo ''
else
  echo "Backend with name ${name} already exists"
fi
