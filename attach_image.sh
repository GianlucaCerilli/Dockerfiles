#!/bin/bash

DOCKER_IMAGE_NAME="$1"
RELEASE="$2"

echo -e "Attaching to the Docker image $DOCKER_IMAGE_NAME\n"

# Check if the Docker image name is valid
if [ "$DOCKER_IMAGE_NAME" != "noble_jazzy" ]
then
  echo "Docker images available: [noble_jazzy]"
  exit
fi

# Check if the optional parameter for the Docker image tag is provided. Otherwise, use "latest" by default
if [ -z "$RELEASE" ]
then
  RELEASE="latest"
fi

# Get the ID of the running Docker container using the image name and tag
DOCKER_CONTAINER_ID=$(docker ps -q --filter "ancestor=$DOCKER_IMAGE_NAME:$RELEASE")

# Check if the container is running
if [ -z "$DOCKER_CONTAINER_ID" ]
then
  echo "No running container found for image '$DOCKER_IMAGE_NAME:$RELEASE'"
  exit 1
fi

# Attach a new terminal to the running Docker container
docker exec -it $DOCKER_CONTAINER_ID bash

exit