#!/bin/bash
. ${HOME}/etc/shell.conf

for lg in $LG_FRAMES ; do
	ACTUALSCREEN=$(echo "$lg" | cut -c3)

	if [ $ACTUALSCREEN == 1 ]; then
		export DISPLAY=:0
		pkill chromium-browse
	else
		sshpass -p $1 ssh -Xnf lg@$lg " pkill chromium-browse "
	fi
    sleep 0.5
done
