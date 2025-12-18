FROM osrf/ros:noetic-desktop-full-focal

RUN apt-get update && apt-get install -y \
  gazebo11 \
  ros-noetic-gazebo-ros-pkgs \
  ros-noetic-gazebo-ros-control \
  ros-noetic-ros-control \
  ros-noetic-ros-controllers \
  ros-noetic-joint-state-publisher \
  ros-noetic-joint-state-controller \
  ros-noetic-robot-state-publisher \
  ros-noetic-robot-localization \
  ros-noetic-xacro \
  ros-noetic-tf2-ros \
  ros-noetic-tf2-tools \
  ros-noetic-dynamixel-sdk \
  ros-noetic-turtlebot3-msgs \
  ros-noetic-turtlebot3 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /catkin_ws/src
COPY ./tortoisebot /catkin_ws/src/tortoisebot
COPY ./tortoisebot_waypoints /catkin_ws/src/tortoisebot_waypoints

WORKDIR /catkin_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Make test script executable
RUN chmod +x /catkin_ws/src/tortoisebot_waypoints/test/tortoisebot_action_server_test.py
RUN chmod +x /catkin_ws/src/tortoisebot_waypoints/src/tortoisebot_waypoints/tortoisebot_action_server.py
RUN chmod +x /catkin_ws/src/tortoisebot_waypoints/src/tortoisebot_waypoints/send_goal.py

# Copy entrypoint script
COPY ./ros1_ci/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
