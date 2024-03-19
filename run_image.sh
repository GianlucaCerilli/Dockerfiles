#!/bin/bash

# Docker image name passed from command line
DOCKER_IMAGE_NAME="$1"
RELEASE="latest"

echo -e "Running the Docker image $DOCKER_IMAGE_NAME\n"

if [ "$DOCKER_IMAGE_NAME" != "jammy_humble" ] && [ "$DOCKER_IMAGE_NAME" != "focal_noetic" ]
then
  echo "Docker images available: [jammy_humble, focal_noetic]"
  exit
fi

DOCKER_IMAGE_VOLUMES="$2"
WORKING_DIRECTORY_PATH="$3"

if [[ "$DOCKER_IMAGE_VOLUMES" == "-v" ]]
then
  if [[ "$WORKING_DIRECTORY_PATH" != "" ]]
  then
    WORKING_DIRECTORY_NAME=$(echo $(basename $WORKING_DIRECTORY_PATH))

    if [[ "$DOCKER_IMAGE_NAME" == "focal_noetic" ]]
    then
      xhost + && docker run --rm -it \
            -e "TERM=xterm-256color" \
            -e DISPLAY=$DISPLAY \
            -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v $WORKING_DIRECTORY_PATH:/home/$USER/catkin_ws/src/$WORKING_DIRECTORY_NAME \
            -w /home/$USER/catkin_ws/src/$WORKING_DIRECTORY_NAME \
            --name $DOCKER_IMAGE_NAME \
            $DOCKER_IMAGE_NAME:$RELEASE
    elif [[ "$DOCKER_IMAGE_NAME" == "jammy_humble" ]]
    then
      xhost + && docker run --rm -it \
            -e "TERM=xterm-256color" \
            -e DISPLAY=$DISPLAY \
            -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v $WORKING_DIRECTORY_PATH:/home/$USER/catkin_ws/src/$WORKING_DIRECTORY_NAME \
            -w /home/$USER/catkin_ws/src/$WORKING_DIRECTORY_NAME \
            --name $DOCKER_IMAGE_NAME \
            $DOCKER_IMAGE_NAME:$RELEASE
    else
      echo "Docker images available: [jammy_humble, focal_noetic]"
    fi
  else
    echo "Missing the working directory path (absolute) that you want to mount"
  fi
elif [[ "$DOCKER_IMAGE_VOLUMES" == "" ]]
then
    xhost + && docker run --rm -it \
           -e "TERM=xterm-256color" \
           -e DISPLAY=$DISPLAY \
           -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -w /home/$USER/catkin_ws/src \
           --name $DOCKER_IMAGE_NAME \
           $DOCKER_IMAGE_NAME:$RELEASE
else
  echo "* Available flags: [-v] to mount volumes in the Docker image"
fi

exit