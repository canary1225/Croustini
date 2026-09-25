#!/bin/bash

# Get the directory where this script is located (xfce/)
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Look for croustini.conf in the parent directory (Croustini/)
CONFIG_PATH="$DIR/../croustini.conf"

if [ -f "$CONFIG_PATH" ]; then
    source "$CONFIG_PATH"
else
    echo "Error: croustini.conf not found in parent directory!"
    exit 1
fi

# Clean up any old instances
# Clean up any old instances and stale lock files
killall Xephyr 2>/dev/null
killall xfce4-session 2>/dev/null
rm -f /tmp/.X2-lock

echo "Launching Xephyr on $DISPLAY_NUM with resolution $SCREEN_RES..."

# Launch Xephyr based on config options
if [ "$USE_GLAMOR" = "true" ]; then
    Xephyr $DISPLAY_NUM -screen $SCREEN_RES -sw-cursor -glamor &
else
    Xephyr $DISPLAY_NUM -screen $SCREEN_RES -sw-cursor &
fi

echo "Waiting for Xephyr to initialize..."
until DISPLAY=$DISPLAY_NUM xdpyinfo >/dev/null 2>&1; do
  sleep 0.5
done

echo "Starting XFCE4 session..."
export DISPLAY=$DISPLAY_NUM
unset WAYLAND_DISPLAY
export GDK_BACKEND=x11

startxfce4 &
