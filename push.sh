#!/bin/bash
IMAGE_NAME="dev-docker-registry.org.com/common/jenkins-node-java"
IMAGE_ID="$(docker images -q ${IMAGE_NAME}:latest)"
IMAGE_TAG="jdk-8-u1"
docker tag ${IMAGE_ID} ${IMAGE_NAME}:${IMAGE_TAG}
docker push ${IMAGE_NAME}:${IMAGE_TAG}
