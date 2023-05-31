#!/usr/bin/env sh

FILE=$1
name=$(cat $FILE | jq -r '.name')
if [ -z $(curl -X GET app.wilhelm-gateway.starburst-customer-success.com/gateway/backend/active 2>/dev/null | jq -r '.[].name' | grep -x "${name}") ]; then
  curl -H "Content-Type: application/json" -X POST https://app.wilhelm-gateway.starburst-customer-success.com/gateway/backend/modify/add -d @${FILE}
  echo ''
else
  echo "Backend with name ${name} already exists"
fi
