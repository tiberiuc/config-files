#!/bin/bash

export TERM=screen-256color-bce

tmux -2 has-session -t  sitedity 2>/dev/null

if [ "$?" -eq 1 ]; then
    tmux -2 new-session -d -s sitedity
    tmux -2 rename-window Sitedity
    tmux -2 send-keys 'cd ~/work/sitedity; m' 'C-m'
    tmux -2 split-window -h
    tmux -2 send-keys 'cd ~/work/sitedity; v' 'C-m'
    tmux -2 split-window -v -t 0
    tmux -2 send-keys 'cd ~/work/sitedity/scripts; rake' 'C-m'
fi

tmux -2 attach-session -t sitedity

