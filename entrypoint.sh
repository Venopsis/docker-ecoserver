#!/bin/bash

if [ "$#" -eq "Init" ]
    then
        # Does nothing to let user manage config file before first run.
elif [ "$#" -eq "0" ]
    then
        # Start in Tmux session for late management
        tmux new-session -d -s "ecoserver" mono EcoServer.exe -nogui
else
    echo "This container does not accept arguments"
    exit 1
fi

exec "$@"