# Autonomous Mobile Robots Labs and Assignments

[![MATLAB](https://img.shields.io/badge/MATLAB-R2021b%20or%20later-blue.svg)](https://www.mathworks.com/products/matlab.html)

This repository contains my solutions to the practical assignments and labs for the **Autonomous Mobile Robots (ME525)** course. The labs cover various topics and techniques in robotics, including trajectory generation, camera projection, gait investigation for legged robots, Kalman Filtering, time-to-collision estimation, etc. Each lab and assignment is detailed in its respective directory. 

Here's a summary of some of the implementations:

## 1: Quadrupedal Robot Design and Control

This lab focused on exploring walking locomotion types by constructing and controlling a simple quadrupedal robot. MATLAB was used to program the robot's movements, enabling it to move forward, backward, leftward, and rightward, with adjustable speed. The lab also involved calibrating the robot's leg positions to ensure smooth walking.

## 2: Two-Wheeled Robot Construction and Odometry Estimation

In this lab, a two-wheeled robot was constructed and equipped with a camera to estimate odometry and track its position on the global x-y plane. MATLAB and webcam support packages were used to capture images and process them to calculate odometry and trajectory. Different motion scenarios, including linear and circular motion, were tested.

## 3: Range Finder Sensor Building and Data Processing

This lab focused on building a range finder sensor using an infrared sensor and a large motor. MATLAB was used to process the distance measurements and calculate time-to-collision (TTC) with obstacles. The lab involved testing different scenarios with fixed and moving obstacles.

## 4: Kalman Filter Implementation

This lab involved implementing a Kalman filter on a differential drive two-wheeled robot with an infrared sensor. MATLAB was used to simulate the estimation process and plot the whole state vector. The lab included discussions on the Kalman gain and variance convergence.

## 5: Trajectory Generation for a Legged Robot

This assignment focused on generating trajectories for a legged robot with 6 legs. MATLAB was used to generate x, y, and z directional foot tip references for foot numbers 1 and 2 expressed in the body-attached coordinate frame. The lab involved using 1-cos type curves to create smooth trajectories.

## 6: Camera Projection

This assignment involved solving a camera projection problem. MATLAB was used to find the pixel coordinates of a point in the image frame based on given parameters such as image plane size, image frame size, focal length, and rotation matrix.

## 7: Visibility Graph Path Planning

This assignment focused on path planning using the visibility graph approach. MATLAB was used to find the shortest path for a mobile robot from a start point to a goal point while avoiding obstacles represented by line segments on the x-y plane.

*Note: This contents of this repository were part of a robotics course. All credit goes to the instructors and the institution for providing the opportunity to undertake this project.*