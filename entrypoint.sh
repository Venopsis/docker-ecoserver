#!/bin/bash
#
if [ "$1" = "Init" ]
    then
        # Run bash to let user edit configuration before first run.
        bash
elif [ "$1" = "Start" ]
    then
        # Start in Tmux session for late management
        tmux new-session -d -s "ecoserver" "mono EcoServer.exe -nogui"
else
    echo "This container does not accept arguments"
    exit 1
fi

exec "$@"