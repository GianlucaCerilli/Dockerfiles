#!/bin/bash

echo "Configuration of the workspaces, build and source"

# Source ROS2 Jazzy Jalisco
echo -e "\n# Source ROS2 Jazzy setup" >> $HOME/.bashrc
echo "source /opt/ros/jazzy/setup.bash" >> $HOME/.bashrc

# Source the local setup for ROS workspace (so that, for new Docker terminals it is already sourced from the .bashrc)
echo -e "\n# Source the local ROS2 workspace setup" >> $HOME/.bashrc
echo "source \$HOME/ros2_ws/install/local_setup.bash" >> $HOME/.bashrc

# Create the ROS2 workspace
mkdir -p $HOME/ros2_ws/src
cd $HOME/ros2_ws

# Resolve dependencies
sudo rosdep init
rosdep update
rosdep install -i --from-path src --rosdistro jazzy -y

# Build the workspace with colcon
colcon build

# References
# https://docs.ros.org/en/jazzy/Tutorials/Beginner-Client-Libraries/Creating-A-Workspace/Creating-A-Workspace.html#id7