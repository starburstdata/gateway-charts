#!/usr/bin/env sh
set -x
curl -LJO https://raw.githubusercontent.com/starburstdata/presto-gateway/master/gateway-ha/src/main/resources/gateway-ha-persistence.sql
user=$(yq -r '.backendDatabase.user' ./example-values.yaml)
password=$(yq -r '.backendDatabase.password' ./example-values.yaml)
mysql  -u${user} -h gateway-wm.cluster-ro-cng06bp9tay1.us-east-2.rds.amazonaws.com -p${password} gateway < gateway-ha-persistence.sql