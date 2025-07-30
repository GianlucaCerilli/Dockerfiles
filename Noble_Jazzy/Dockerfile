# Install Ubuntu 24.04.2 LTS Noble Numbat
FROM ubuntu:24.04

# Get the user name, user id and group id from the host (if passed, when building the docker image)
# Their default values are "user", "1000:1000"
ARG USER=user
ARG USER_ID=1000
ARG GROUP_ID=1000

# Define USER and HOME environment variables to match the non-root user context.
# This ensures that any tools or scripts relying on $USER or $HOME 
# use the intended paths (/home/$USER), preventing unexpected fallback to /home/ubuntu.
ENV USER=${USER}
ENV HOME=/home/${USER}

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
    wget \
    git \
    libeigen3-dev \
    libgtest-dev \
    mesa-utils

# Add a user and a group, based on their id
RUN groupadd -g $GROUP_ID -o $USER \
    && useradd --no-log-init -m -u $USER_ID -g $GROUP_ID -o -s /bin/bash $USER \
    && usermod -aG sudo $USER \
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo "\n### Noble Jazzy docker image ###" >> $HOME/.bashrc

# To make gedit work (installation of dbus-x11 and this export)
RUN echo "\n# Export variables for gedit" >> $HOME/.bashrc
RUN echo "export \$(dbus-launch)" >> $HOME/.bashrc

USER root

# Add the scripts to install ROS2 Jazzy Jalisco, Gazebo Harmonic 
# and configure the ROS2 workspace still as root
ADD Noble_Jazzy/scripts/install_ros2_jazzy_jalisco.sh /home/$USER/
ADD Noble_Jazzy/scripts/install_gazebo_harmonic.sh /home/$USER/
ADD Noble_Jazzy/scripts/configure_workspace.sh /home/$USER/

# Set the permissions to run the scripts as the user
RUN chown $USER:$USER /home/$USER/*.sh && chmod +x /home/$USER/*.sh

USER $USER
WORKDIR /home/$USER

# Install ROS2 Jazzy Jalisco
RUN "./install_ros2_jazzy_jalisco.sh"

# Install Gazebo Harmonic
RUN "./install_gazebo_harmonic.sh"

# Configure the ROS 2 workspace
RUN "./configure_workspace.sh"

# Remove the installation scripts from the image
RUN rm $HOME/install_ros2_jazzy_jalisco.sh
RUN rm $HOME/install_gazebo_harmonic.sh
RUN rm $HOME/configure_workspace.sh