# https://husarion.com/tutorials/ros-tutorials/5-running-ros-on-multiple-machines/

# 1st device (pi - 192.168.1.27)
export ROS_MASTER_URI=http://192.168.1.27:11311
export ROS_IP=192.168.1.27

# 2nd device (tren - 192.168.1.19)
export ROS_MASTER_URI=http://192.168.1.27:11311
export ROS_IP=192.168.1.19