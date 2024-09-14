# satisfactory-server

This is a Dockerfile and Makefile build script to generate a Docker image for the dedicated [Satisfactory](https://store.steampowered.com/app/526870/Satisfactory/) game server.

This Dockerfile is confirmed working with the Satisfactory 1.0 Release (and previously supported Update 8 as well).

## Features

* Two-stage build process for an optimized container image
* No automatic server patch updates (yes, this is a feature)
* Exported paths to local filesystem for game configuration and saves

## How To Use

To build the container, simply clone this repo and run:

```
make 
```

Once the container is built, you can then start execution with:

```
make run
```

This will create a `satisfactory/` directory within your HOME directory that exports the game configuration and saved games to the local filesystem (so they can be backed up and/or settings modified).

If you wish to use a different directory, override the root path when running like so:

```
make SSROOT=/my/root/path
```

If you should ever need to shell into a running server container, use:

```
make shell
```

Lastly, to remove the built image, use:

```
make clean
```

## Notes

This Dockerfile utilizes a two-stage build process to generate an optimized container with just the game server binary.

The first stage uses `steamcmd` to login anonymously to Steam and download the [Satisfactory server](https://steamdb.info/app/1690800/info/) (Steam App ID #1690800).

The second stage then creates a fresh Debian 12 image and copies the downloaded server package from the first stage into it.

Note that this build script intentionally does not perform patch updates through `steamcmd`.  If you want to get an updated version of the server (if there is any), delete and rebuild the Docker container.

