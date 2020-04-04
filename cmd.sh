#/bin/bash

if [[ $# -eq 0 ]]; then
    echo "Need at least one argument, say 'help'"
    exit 0
fi

time=$(date +%Y-%m-%dT%T.%N)
# grab all commands past the first argument
commands="${@:1}"
# crazy quoting below to allow passing commands from the command line with spaces in them
# /in is the fifo set up by the wrapper in the docker container
docker exec terraria-server sh -c 'echo "'"$commands"'" > /in'
# alternatively you can do it via fd0
#docker exec terraria-server sh -c 'echo "'"$commands"'" > /proc/$(pgrep -f ^/game/TerrariaServer)/fd/0'
# give it a second to execute
sleep 1
docker logs --since "$time" terraria-server
