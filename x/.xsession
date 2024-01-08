#!/bin/bash
#nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

xrandr --output HDMI-0  --left-of DP-0 
xbindkeys
picom -b
hsetroot -solid '#000000'
export _JAVA_AWT_WM_NONREPARENTING=1
#sleep 2s
#hsetroot

