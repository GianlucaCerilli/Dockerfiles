#!/bin/bash

# Docker image name passed from command line
DOCKER_IMAGE_NAME="$1"
RELEASE="latest"

echo -e "Building the Docker image $DOCKER_IMAGE_NAME\n"

if [[ "$DOCKER_IMAGE_NAME" == "jammy_humble" ]]
then
  DOCKER_IMAGE_DIR="Jammy_Humble"
elif [[ "$DOCKER_IMAGE_NAME" == "focal_noetic" ]]
then
  DOCKER_IMAGE_DIR="Focal_Noetic"
else
  echo "* Missing docker image name: [jammy_humble, focal_noetic]"
  exit
fi

CACHE="$2"

if [[ "$CACHE" == "-nc" ]]
then
  docker build --no-cache \
         --file $DOCKER_IMAGE_DIR/Dockerfile \
         --build-arg USER=$USER \
         --build-arg USER_ID=$(id -u) \
         --build-arg GROUP_ID=$(id -g) \
         --tag $DOCKER_IMAGE_NAME:latest .
elif [[ "$CACHE" == "" ]]
then
  docker build \
         --file $DOCKER_IMAGE_DIR/Dockerfile \
         --build-arg USER=$USER \
         --build-arg USER_ID=$(id -u) \
         --build-arg GROUP_ID=$(id -g) \
         --tag $DOCKER_IMAGE_NAME:latest .
else
  echo "* Missing flag: [-nc] to build without considering the cache"
fi

exit