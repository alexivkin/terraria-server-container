#!/bin/bash

trap 'server_shutdown' SIGTERM

function server_shutdown() {
    echo "Stopping Terraria server..."
    echo exit  > /in
    pid=$(pgrep -f ^/game/TerrariaServer)
    if [ -z "$pid" ]; then echo "Already stopped"; exit 1; fi
    # Wait for it to finish saving and exit
    while [ -e /proc/$pid ]; do
        sleep 1
    done
    echo "done"
    exit 0
}

# creating a named pipe, so java does not close stdin when moved to the background
mkfifo /in
# block the pipe, so it's open forever
sleep 100000d > /in &
# run terraria as the second service
echo "Starting Terraria server..."
# move to background so we can monitor for SIGTERM in this shell
/game/TerrariaServer.bin.x86_64 -config /server.txt < /in &
# Halt while the server is alive
pid=$(pgrep -f ^/game/TerrariaServer)
if [ -z "$pid" ]; then echo "Terraria server did not start!"; exit 1; fi
wait $pid
