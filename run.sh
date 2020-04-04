#!/bin/bash

# start in the background with interaction for sending commands
docker run -d --restart unless-stopped -i --name terraria-server -p 7777:7777 -v $PWD/worlds/:/worlds/ alexivkin/terraria-server
