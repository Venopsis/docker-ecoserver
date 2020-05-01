#!/bin/bash
echo "--------"
echo "Running the container" $(hostname)
echo "Time info :" $(date)
echo "--------"
if [ "$1" = "Init" ]
    then
        # Run bash to let user edit configuration before first run.
        echo $(date) "- Init mode initiated"
        bash
elif [ "$1" = "Start" ]
    then
        echo $(date) "- Tmux session for eco : starting"
        # Start in Tmux session for late management
        tmux new-session -d -s "ecoserver" "mono EcoServer.exe -nogui"
        echo $(date) "- Tmux session for eco : running"
        # Command below keep container running after tmux command done
        tail -f /dev/null
else
    echo $(date) "- !! ERROR !! This container does not accept other arguments than Init and Start"
    exit 1
fi