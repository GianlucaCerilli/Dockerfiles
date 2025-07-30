#!/bin/bash

# Docker image name passed from command line
DOCKER_IMAGE_NAME="$1"
RELEASE="$2"

echo -e "Running the Docker image $DOCKER_IMAGE_NAME\n"

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

DOCKER_IMAGE_VOLUMES="$3"

# Absolute path to the folder (included) that you want to mount in the container
WORKING_DIRECTORY_PATH="$4"

# Check if the optional parameter -v is provided. Otherwise, do not mount volumes by default
if [ "$DOCKER_IMAGE_VOLUMES" == "-v" ]
then
  if [ -z "$WORKING_DIRECTORY_PATH" ]
  then
    echo "Missing the absolute path to the folder (included) that you want to mount in the container"
    exit
  else
    # Get the name of the folder that you want to mount in the container
    WORKING_DIRECTORY_NAME=$(echo $(basename $WORKING_DIRECTORY_PATH))
    VOLUMES_COMMAND="$DOCKER_IMAGE_VOLUMES $WORKING_DIRECTORY_PATH:/home/$USER/ros2_ws/src/$WORKING_DIRECTORY_NAME"
  fi
elif [ "$DOCKER_IMAGE_VOLUMES" != "-v" ] && [ "$DOCKER_IMAGE_VOLUMES" != "" ]
then
  # Invalid optional parameter
  echo "* Optional parameters: [-v] to mount volumes in the container"
  exit
fi

# Run the Docker image with the name provided
if [ "$DOCKER_IMAGE_NAME" == "noble_jazzy" ]
then
  xhost + && docker run --rm -it \
        -e "TERM=xterm-256color" \
        -e DISPLAY=$DISPLAY \
        -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        $VOLUMES_COMMAND \
        -w /home/$USER/ros2_ws/src/$WORKING_DIRECTORY_NAME \
        --name $DOCKER_IMAGE_NAME \
        $DOCKER_IMAGE_NAME:$RELEASE
else
  echo "Docker images available: [noble_jazzy]"
fi

exit