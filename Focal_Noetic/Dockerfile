# Install Ubuntu 20.04.6 LTS Focal Fossa
FROM ubuntu:20.04

# Get the user name, user id and group id from the host (if passed, when building the docker image)
# Their default values are "user", "1000:1000"
ARG USER=user
ARG USER_ID=1000
ARG GROUP_ID=1000

# Add a user and a group, based on their id
RUN groupadd -g $GROUP_ID -o $USER
RUN useradd --no-log-init -m -u $USER_ID -g $GROUP_ID -o -s /bin/bash $USER

# Create a working directory
WORKDIR /home/$USER

# Set the non-interactive debian frontend
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update, upgrade and install apt packages
RUN apt update && apt upgrade -y && apt autoremove -y
RUN apt install -y \
    --no-install-recommends \
    sudo \
    cmake \
    g++ \
    python3-pip \
    build-essential \
    apt-utils \
    curl \
    bash-completion \
    lsb-release \
    gnupg2 \
    iputils-ping \
    net-tools \
    nano \
    dbus-x11 \
    gedit \
    htop \
    mlocate \
    wget \
    git \
    libeigen3-dev \
    libgtest-dev

RUN echo "\n### Focal Noetic docker image ###" >> /home/$USER/.bashrc

# To make gedit work (installation of dbus-x11 and this export)
RUN echo "\n# Export variables for gedit" >> /home/$USER/.bashrc
RUN echo "export \$(dbus-launch)" >> /home/$USER/.bashrc

# Install ROS Noetic Ninjemys
ADD Focal_Noetic/scripts/install_ros_gazebo_moveit.sh $WORKDIR
RUN "/home/$USER/install_ros_gazebo_moveit.sh"

# Add the user "user" to the sudo group
RUN adduser $USER sudo

# Add a line to the "/etc/sudoers" file that allows all users in the sudo group to run all commands without a password
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER

# Configure the ROS 1 workspace 
ADD Focal_Noetic/scripts/configure_workspace.sh $WORKDIR
RUN "/home/$USER/configure_workspace.sh" "$USER"

RUN . /home/$USER/.bashrc

# Remove the installation scripts from the image
RUN sudo rm /home/$USER/install_ros_gazebo_moveit.sh
RUN sudo rm /home/$USER/configure_workspace.sh