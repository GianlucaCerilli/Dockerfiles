#!/bin/bash

echo "Configuration of the workspaces, build and source"

# Source ROS Noetic Ninjemys
echo -e "\n# Source ROS Noetic setup" >> /home/$USER/.bashrc
echo "source /opt/ros/noetic/setup.bash" >> /home/$USER/.bashrc

# Create the ROS (catkin) workspace, build it and source
mkdir -p /home/$USER/catkin_ws/src

# Clone and configure gazebo_ros_pkgs
cd /home/$USER/catkin_ws/src
git clone https://github.com/ros-simulation/gazebo_ros_pkgs.git -b noetic-devel

# Check for any missing dependencies and install them if needed
rosdep update
rosdep check --from-paths . --ignore-src --rosdistro noetic
rosdep install --from-paths . --ignore-src --rosdistro noetic -y

# Build the catkin_ws
cd /home/$USER/catkin_ws
source /opt/ros/noetic/setup.bash
catkin_make -j4

echo -e "\n# Source the catkin_ws setup.bash" >> /home/$USER/.bashrc
echo "source /home/$USER/catkin_ws/devel/setup.bash" >> /home/$USER/.bashrc