#!/bin/bash
if xrandr | grep ^DP1
then
  if [ "$1" == "right" ]
  then
    xrandr --output eDP1 --auto --output DP1 --auto --panning 3168x1782+3200+0 --scale 1.65x1.65 --right-of eDP1
  elif [ "$1" == "left" ]
  then
    xrandr --output eDP1 --auto --output DP1 --auto --scale 1.65x1.65 --left-of eDP1
  fi
fi
