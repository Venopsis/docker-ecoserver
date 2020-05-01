#!/bin/bash
#
if [ "$1" = "Init" ]
    then
        # Run bash to let user edit configuration before first run.
        bash
elif [ "$1" = "Start" ]
    then
        echo "Go into option Start"
        # Start in Tmux session for late management
        echo "Run tmux command"
        tmux new-session -d -s "ecoserver" "mono EcoServer.exe -nogui"
        echo "Leaving tmux"
        echo "execute tail command"
        tail -f /dev/null
        echo "leaving tail command"
else
    echo "This container does not accept arguments"
    exit 1
fi
echo "Out of else if loop"