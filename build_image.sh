#!/bin/bash

# Docker image name passed from command line
DOCKER_IMAGE_NAME="$1"
RELEASE="$2"

USER_ID=$(id -u)
GROUP_ID=$(id -g)

echo -e "Building the Docker image $DOCKER_IMAGE_NAME\n"

# Check if the Docker image name is valid and find the corresponding directory
if [ "$DOCKER_IMAGE_NAME" == "noble_jazzy" ]
then
  DOCKER_IMAGE_DIR="Noble_Jazzy"
else
  echo "* Missing docker image name: [noble_jazzy]"
  exit
fi

# Check if the optional parameter for the Docker image tag is provided. Otherwise, use "latest" by default
if [ -z "$RELEASE" ]
then
  RELEASE="latest"
fi

NO_CACHE="$3"

# Check if the optional parameter --no-cache is provided. Otherwise, use the cache by default
if [ "$NO_CACHE" != "" ] && [ "$NO_CACHE" != "--no-cache" ]
then
  echo "* Optional parameters: [--no-cache] to build without considering the cache"
  exit
fi

# Build the Docker image
docker build $NO_CACHE \
       --file $DOCKER_IMAGE_DIR/Dockerfile \
       --build-arg USER="$USER" \
       --build-arg USER_ID="$USER_ID" \
       --build-arg GROUP_ID="$GROUP_ID" \
       --tag $DOCKER_IMAGE_NAME:$RELEASE .

exit