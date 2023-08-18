#!/usr/bin/env bash

set -xeuo pipefail
JAVA_HOME=`/usr/libexec/java_home -v 11`
GATEWAY_VERSION=$1
TAG=$2

target='main'
#'release-0.1'
repo='git@github.com:starburstdata/presto-gateway.git'

# clone
git clone -q ${repo}

# build
pushd presto-gateway
git checkout ${target}
mvn --quiet clean install -DskipTests
# get JAR file
cp gateway-ha/target/gateway-ha-$GATEWAY_VERSION-jar-with-dependencies.jar ..
popd
# build docker image
CONTAINER="gateway:${GATEWAY_VERSION}-${TAG}"
docker build . --pull --platform linux/amd64 -f Dockerfile -t ${CONTAINER}-amd64 --build-arg="GATEWAY_VERSION=${GATEWAY_VERSION}"
docker build . --pull --platform linux/arm64 -f Dockerfile -t ${CONTAINER}-arm64 --build-arg="GATEWAY_VERSION=${GATEWAY_VERSION}"
docker image inspect -f '🚀 Built {{.Id}}' ${CONTAINER}-amd64
docker image inspect -f '🚀 Built {{.Id}}' ${CONTAINER}-arm64
# cleanup
rm -rf presto-gateway
rm gateway-ha-$GATEWAY_VERSION-jar-with-dependencies.jar
