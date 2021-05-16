#!/bin/sh
# def
ibus-daemon=false
ibus=$(ibus-daemon)
kitty="GLFW_IM_MODULE=ibus kitty"

# up
if [ $ibus = ture ] then
    exec $kitty
elif [ $kitty = false ] then
    pkill $ibus
fi
