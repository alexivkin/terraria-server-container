# Terraria server in a docker container

Allows graceful shutdown by issuing the `exit` command to the server when the docker container is stopped,

* Building

You need to copy the "game" folder from the game into the buildcontext folder. Then run

	docker build -t alexivkin/terraria-server buildcontext

* Running

If you have a world you would like to use copy it to `worlds/world.wld` otherwise a new world will be created for you on the first run. Start by running `./run.sh`

* Checking

Run `./cmd.sh help`

* Known issues

If the server crashes for whatever reason the docker container will keep running. This is so you can see the logs from the crash.
if you want to terminate container when server crashes comment out the forever wait loop in the serverwatcher.sh
