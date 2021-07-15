#!/bin/bash

mouses_id=$(xinput list | grep pointer | egrep -o "id=[[:digit:]]{1,2}" | egrep -o "[[:digit:]]{1,2}")
for mouse_id in $mouses_id
do
   eval "$(xinput set-button-map $mouse_id 1 1 3 5 4 7 6 0 0 0 0 0)"
done
