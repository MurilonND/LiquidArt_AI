#!/bin/bash

. ${HOME}/etc/shell.conf

port=3000
screenNumber=0;
for lg in $LG_FRAMES ; do
    screenNumber=${lg:2}
    if [ $lg == "lg1" ]; then
        export DISPLAY=:0
        nohup chromium-browser http://$2:$port --start-fullscreen </dev/null >/dev/null 2>&1 &
    else
        sshpass -p $1 ssh -Xnf lg@$lg " export DISPLAY=:0 ; chromium-browser http://$2:$port/$screenNumber --start-fullscreen </dev/null >/dev/null 2>&1 &" || true
    fi
done

exit 0
