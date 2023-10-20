#!/usr/bin/env sh
set -x

which psql > /dev/null
if [ $? -ne 0 ]; then
  echo 'Install psql before running this script. Goodbye.'
  exit 1
fi

user=$(yq -r '.backendDatabase.user' ./example-values.yaml)
PGPASSWORD=$(yq -r '.backendDatabase.password' ./example-values.yaml)
host=$(yq -r '.backendDatabase.host' ./example-values.yaml)
curl -LJO https://raw.githubusercontent.com/starburstdata/trino-gateway/master/gateway-ha/src/main/resources/gateway-ha-persistence-postgres.sql
psql  -U ${user} -h ${host} postgres -c 'CREATE DATABASE gateway'
psql  -U ${user} -h ${host} gateway -f gateway-ha-persistence.sql
