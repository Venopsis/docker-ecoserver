#!/bin/bash

if [ "$#" -eq "Init" ]
    then
        # Does nothing to let user manage config file before first run.
fi

if [ "$#" -eq "0" ]
    then
        # Start in Tmux session for late management
        tmux new-session -d -s "ecoserver" mono EcoServer.exe -nogui
else
    echo "Only Init for first run or nothing is accepted as arguments."
    exit 1
fi

exec "$@"