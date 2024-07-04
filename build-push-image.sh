#!/bin/bash

# Variables
DOCKER_USERNAME="rappercharmer"
IMAGE_NAME="plantlife-api"
TAG="latest"

# Remove the existing Docker image
docker rmi -f $IMAGE_NAME

# Build the Docker image
docker build -t $IMAGE_NAME .

# Tag the Docker image
docker tag $IMAGE_NAME $DOCKER_USERNAME/$IMAGE_NAME:$TAG

# Log in to Docker Hub
docker login

# Push the Docker image to Docker Hub
docker push $DOCKER_USERNAME/$IMAGE_NAME:$TAG
