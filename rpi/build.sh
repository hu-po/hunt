#

# get version of raspberry linux
cat /etc/os-release

# ROS Installation
# http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Kinetic%20on%20the%20Raspberry%20Pi

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo -E apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt clean
sudo apt update
sudo apt-get upgrade

sudo apt-get install -y python-rosdep \
    python-rosinstall-generator \
    python-wstool \
    python-rosinstall \
    build-essential \
    cmake \
    libeigen3-dev \
    libyaml-cpp-dev

sudo rosdep init
rosdep update

mkdir -p ~/ros_catkin_ws
cd ~/ros_catkin_ws

rosinstall_generator ros_comm --rosdistro noetic --deps --wet-only --tar > noetic-ros_comm-wet.rosinstall
wstool init src noetic-ros_comm-wet.rosinstall

rosdep install -y --from-paths src --ignore-src --rosdistro noetic -r --os=debian:buster
sudo ./src/catkin/bin/catkin_make_isolated --install -DPYTHON_EXECUTABLE=/usr/bin/python3 -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/noetic -j2

echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Dynamixel Installation
# http://wiki.ros.org/dynamixel_workbench
mkdir ~/dynamixel && cd ~/dynamixel
git clone --branch noetic-devel https://github.com/ROBOTIS-GIT/dynamixel-workbench.git
git clone --branch noetic-devel https://github.com/ROBOTIS-GIT/dynamixel-workbench-msgs.git
git clone --branch noetic-devel https://github.com/ROBOTIS-GIT/DynamixelSDK.git

# Make DynamixelSDK
cd ~/dynamixel/DynamixelSDK/c++/build/linux_sbc/
make clean && make
sudo make install

# Discover Dynamixel servos
# https://emanual.robotis.com/docs/en/software/dynamixel/dynamixel_workbench/
# https://github.com/ROBOTIS-GIT/dynamixel-workbench/issues/294
cd ~/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples
mkdir -p build && cd build
cmake ..
make

# setup U2D2
wget https://raw.githubusercontent.com/ROBOTIS-GIT/dynamixel-workbench/master/99-dynamixel-workbench-cdc.rules
sudo cp ./99-dynamixel-workbench-cdc.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

# discover dynamixels
ls /dev/tty*
cd ~/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/build
./find_dynamixel /dev/ttyUSB0

# Succeed to init(1000000)
# Wait for scan...
# Find 1 Dynamixels
# id : 3, model name : MX-106-2

# Make new ROS workspace
mkdir ~/ros_hunt_ws
mkdir ~/ros_hunt_ws/src
mkdir ~/ros_hunt_ws/build
mkdir ~/ros_hunt_ws/devel

# Copy Dynamixel dependencies into new workspace
cp -r ~/dynamixel/dynamixel-workbench/dynamixel_workbench ~/ros_hunt_ws/src/dynamixel_workbench
cp -r ~/dynamixel/dynamixel-workbench/dynamixel_workbench_controllers ~/ros_hunt_ws/src/dynamixel_workbench_controllers
cp -r ~/dynamixel/dynamixel-workbench/dynamixel_workbench_operators ~/ros_hunt_ws/src/dynamixel_workbench_operators
cp -r ~/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox ~/ros_hunt_ws/src/dynamixel_workbench_toolbox
cp -r ~/dynamixel/dynamixel-workbench-msgs/dynamixel_workbench_msgs ~/ros_hunt_ws/src/dynamixel_workbench_msgs
cp -r ~/dynamixel/DynamixelSDK/ros/dynamixel_sdk ~/ros_hunt_ws/src/dynamixel_sdk
cp -r ~/dynamixel/DynamixelSDK/ros/dynamixel_sdk_examples ~/ros_hunt_ws/src/dynamixel_sdk_examples

# Get ROS dependencies
cd ~/Downloads
git clone --branch noetic-devel https://github.com/ros/common_msgs.git
cp -r ~/Downloads/common_msgs/geometry_msgs ~/ros_hunt_ws/src/geometry_msgs
cp -r ~/Downloads/common_msgs/sensor_msgs ~/ros_hunt_ws/src/sensor_msgs
cp -r ~/Downloads/common_msgs/trajectory_msgs ~/ros_hunt_ws/src/trajectory_msgs
