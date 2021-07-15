#!/bin/bash
#nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

xrandr --output HDMI-0 --rotate left --left-of DP-0
xbindkeys
picom -b
hsetroot -solid '#000000'
#sleep 2s
#hsetroot

