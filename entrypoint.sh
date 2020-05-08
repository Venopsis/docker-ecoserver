#!/bin/bash
echo "--------"
echo "Running the container" $(hostname)
echo "Time info :" $(date)
echo "--------"
if [ "$1" = "Init" ]
    then
        echo $(date) "- Init mode initiated"    
        # Run web file manager Cloud Command in background
        cloudcmd &
        # Run bash to let user edit configuration before first run
        bash
elif [ "$1" = "Start" ]
    then
        echo $(date) "- Tmux session for eco : starting"
        # Start in Tmux session for late management
        tmux new-session -d -s "ecoserver" "mono EcoServer.exe -nogui"
        echo $(date) "- Tmux session for eco : running"
        # Run web file manager Cloud Command in background
        cloudcmd &
        # Command below keep container running after tmux command done
        ## Check if still needed as running cloud cmd in background as last command ##
        tail -f /dev/null
else
    echo $(date) "- !! ERROR !! This container does not accept other arguments than Init and Start"
    exit 1
fi