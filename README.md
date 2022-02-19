# WIP
This is currently being developed, **DO NOT** create server containers with it yet.

# Docker-Srcds
A docker image that installs and runs an srcds server for the specified game.

### What's different about this than the others?
It not only installs the server you want, but also simultaneously updates, validates files, and runs it on container start. All files are created at runtime, meaning you can mount the container to the host filesystem and easily manage the server there. See examples below.

### How do the auto updates work?
The server updates in the background after it launches, if it becomes outdated; simply restart it.

## Examples
* Creating a Garry's Mod server
```docker run -it --env SRCDS_APPID=4020 --name "my-gmod-server" ethorbit/srcds-server:latest```

* Creating a Garry's Mod server that runs as my host user and mounting it somewhere in my home directory
```docker run -it -v /home/ethorbit/Servers/my-gmod-server:/home/srcds/server --env SRCDS_APPID=4020 --env USER_ID=1000 --env GROUP_ID=1000 --name "my-gmod-server" ethorbit/srcds-server:latest```

## Environment Variables
* `SRCDS_APPID`

This is the Steam game's appid that you want srcds to install. (See https://developer.valvesoftware.com/wiki/Steam_Application_IDs)
<br></br>
This can only be used on the first launch, but if you mount the container, you can modify the generated install.sh script.

* `SRCDS_RUN_ARGS`

This represents the properties of your server (map, rcon password, etc) to apply when starting the server. (See https://developer.valvesoftware.com/wiki/Command_Line_Options)

* `USER_ID` `GROUP_ID`

The user and group ids that the docker container will run under. If you plan to mount the container to your system, you'll want this to match the user you plan to modify the files on (so that there's no permission issues)

* `SRCDS_AUTOUPDATE`

This will update and validate files in the background when the server is started; it's on by default.

* `SRCDS_UPDATE`

This is only useful if you have `SRCDS_AUTOUPDATE` set to 0. Having this option set to 1 means when the container runs; an update and file validation process will take place, and the server won't start until it's done.
