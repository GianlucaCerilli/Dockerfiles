#!/bin/bash

echo "Installation of ROS2 Jazzy Jalisco"

# Set locale
locale
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale

# Enable required repositories
sudo apt install -y software-properties-common
sudo add-apt-repository universe -y

sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb

# Install development tools
sudo apt update && sudo apt install -y ros-dev-tools

# Install ROS2 Jazzy Jalisco
sudo apt update
sudo apt upgrade
sudo apt install -y ros-jazzy-desktop

# Setup environment
source /opt/ros/jazzy/setup.bash

# References
# https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html#id4