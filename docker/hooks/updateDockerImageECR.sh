#!/bin/bash

set -e 

DOCKER_IMAGE_NAME="wemap-osrm-frontend"
DOCKER_IMAGE_TAG="$([ ! -z "$1" ] && echo $1 || echo $(git rev-parse --short HEAD))"
AWS_ECR_REPO="028996598430.dkr.ecr.eu-west-1.amazonaws.com/$DOCKER_IMAGE_NAME"
AWS_DEFAULT_REGION="eu-west-1"

cd docker
docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG -f Dockerfile ..
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $AWS_ECR_REPO
docker tag $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG $AWS_ECR_REPO:$DOCKER_IMAGE_TAG
docker push $AWS_ECR_REPO:$DOCKER_IMAGE_TAG