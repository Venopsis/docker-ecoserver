Preparation:
Create volume to store the server data with the following command:
sudo docker volume create ecoserver-dev_data

By default time zone for the container is set to Europe/Brussels.
If you want to change, include the option below
-e "TZ=yourValue"

First run:
sudo docker run --rm --name ecoserver-dev_01 -v ecoserver-dev_data:/opt/eco -it venopsis/ecoserver-dev:latest Init
Get bash in foreground.
When config done, just press ctrl^d to leave container -> will be stopped and removed but not the volume (keep config)

Second run:
sudo docker run --name ecoserver-dev_01 -v ecoserver-dev_data:/opt/eco -p 3000:3000/udp -p 3001:3001 -d venopsis/ecoserver-dev:latest Start
This will run the container in detached mode (background) with the ecoserver starting and loading config files from the attached volume.

If you want to change the defaults port use the following command:
sudo docker run --name ecoserver-dev_01 -v ecoserver-dev_data:/opt/eco -e "GAME_PORT=4000/udp" -e "WEB_PORT=4001" -p 4000:4000/udp -p 4001:4001 -d venopsis/ecoserver-dev:latest Start
WARNING : do not forget to change in configuration file in the initial run!!

Manage the server:
DO NOT USE ATTACH COMMAND OR YOU'LL KILL THE CONTAINER ON EXIT WITH CTRL^D
The eco server will run in tmux session. Then you can connect to the container as following:
sudo docker exec -it ecoserver-dev_01 bash
Type the following command to access ecoserver tmux instance and see log.
root@containerName:/opt/eco# tmux at -t ecoserver
If you want to edit files, etc simply continue in the bash command that showed up.

STOP the server:
Connect as you want to manager the server + load tmux session
Then type exit in the CLI
Then disconnect from the container and stop it from you web interface or CLI.

Copy data from the container:
sudo docker cp ecoserver-dev_01:containerpath localpath 
example -> sudo docker cp ecoserver-dev_01:/opt/eco/Configs .
This will copy the folder "Configs" into the actual folder on your host.

Copy data to the container:
sudo docker cp localpath ecoserver-dev_01:containerpath 
example -> sudo docker cp ecoserver-dev_01:/opt/eco/Configs .

Leave the server:
From bash : ctrl^d
From tmux : ctrl^b + d
