#/bin/sh

DISPLAYPORT=`xrandr | grep DisplayPort | grep " connected" | cut -f 1 -d " "`

xrandr --output LVDS --mode 1440x900
xrandr --output $DISPLAYPORT --mode 1920x1080
xrandr --output $DISPLAYPORT --auto --right-of LVDS
