#!/bin/bash

. ${HOME}/etc/shell.conf

port=3000
screenNumber=0

# Array to store processed machines
processed=()

for lg in $LG_FRAMES ; do
    # Extract the screen number from the machine name
    screenNumber=${lg:2}

    # Check if the machine has already been processed
    if [[ ! " ${processed[@]} " =~ " ${lg} " ]]; then
        processed+=("$lg") # Add the machine to the processed list

        if [ $lg == "lg1" ]; then
            export DISPLAY=:0
            nohup chromium-browser http://$2:$port/$screenNumber --start-fullscreen </dev/null >/dev/null 2>&1 &
        else
            sshpass -p $1 ssh -Xnf lg@$lg " export DISPLAY=:0 ; chromium-browser http://$2:$port/$screenNumber --start-fullscreen </dev/null >/dev/null 2>&1 &" || true
        fi
    fi
done

exit 0
