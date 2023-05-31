#!/usr/bin/env sh
name=$(cat $1 | jq -r '.name')

echo "Removing backend: ${name}"
curl -X POST -d "${name}" https://request.wilhelm-gateway.starburst-customer-success.com/gateway/backend/modify/delete
