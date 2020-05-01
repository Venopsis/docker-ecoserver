#!/bin/bash

tmux new-session -d -s "ecoserver" "mono EcoServer.exe -nogui"
bash