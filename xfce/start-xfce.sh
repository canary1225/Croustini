#!/bin/bash

# Find an available display number or default to :2
DISPLAY_NUM=":2"

echo "Launching Xephyr display on $DISPLAY_NUM..."
# Starts a resizable 1280x800 window (adjust resolution as needed)
Xephyr $DISPLAY_NUM -screen 1280x800 -resizable &

# Give Xephyr a second to spin up
sleep 1

echo "Starting XFCE4 session..."
DISPLAY=$DISPLAY_NUM startxfce4 &