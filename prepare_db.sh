#!/usr/bin/env sh
set -x

which mysql > /dev/null
if [ $? -ne 0 ]; then
  curl -LJO https://repo.mysql.com//mysql80-community-release-el9-1.noarch.rpm
  dnf install -y mysql80-community-release-el9-1.noarch.rpm
  dnf install -y mysql-community-client
fi

user=$(yq -r '.backendDatabase.user' ./example-values.yaml)
password=$(yq -r '.backendDatabase.password' ./example-values.yaml)
host=$(yq -r '.backendDatabase.host' ./example-values.yaml)
curl -LJO https://raw.githubusercontent.com/starburstdata/presto-gateway/ecb874790c5e2bcae07c05d2f7db5d496e5ba99a/gateway-ha/src/main/resources/gateway-ha-persistence.sql
mysql  -u${user} -h${host} -p${password} gateway < gateway-ha-persistence.sql