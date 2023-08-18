#!/bin/sh

set -eux

GATEWAY_VERSION=$1
TAG=$2

NAME=harbor.starburstdata.net/gateway/gateway
IMAGE=gateway:${GATEWAY_VERSION}-${TAG}
TARGET=$NAME:${GATEWAY_VERSION}-${TAG}

./build.sh ${GATEWAY_VERSION} ${TAG}

docker tag $IMAGE-amd64 $TARGET-amd64
docker tag $IMAGE-arm64 $TARGET-arm64
docker push $TARGET-amd64
docker push $TARGET-arm64

docker manifest create $TARGET $TARGET-amd64 $TARGET-arm64
docker manifest push --purge $TARGET

docker manifest create $NAME:latest $TARGET-amd64 $TARGET-arm64
docker manifest push --purge $NAME:latest
