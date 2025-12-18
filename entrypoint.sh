#!/bin/bash
set -e

# Sourcingg
source /opt/ros/noetic/setup.bash
source /catkin_ws/devel/setup.bash

# roscore
echo "Starting roscore..."
roscore &
sleep 5

#  tests
echo "Running tests..."
rostest tortoisebot_waypoints waypoints_test.test

# CLEANUPPPPPPPPP
echo "Cleaning up..."
rosnode kill -a 2>/dev/null || true
killall -9 gzserver gzclient 2>/dev/null || true
pkill -9 roscore 2>/dev/null || true

echo "Tests complete. Exiting."
exit 0