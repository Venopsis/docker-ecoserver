#!/bin/bash

if [ "$#" -eq "0" ]
    then
        # Start in Tmux session for late management
        tmux new-session -d -s "ecoserver" mono EcoServer.exe -nogui
    else
        echo "This container does not accept arguments"
        exit 1

exec "$@"