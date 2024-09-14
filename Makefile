# change this root path (if desired) or run make with: make SSROOT=/my/root/path run
SSROOT			= ${HOME}/satisfactory

# define config and saved paths
SS_CONFIG		= ${SSROOT}/config
SS_SAVED		= ${SSROOT}/saved

all:
	docker build --platform linux/amd64 -t satisfactory-server .

run:
	@mkdir -p ${SS_CONFIG} ${SS_SAVED}
	docker run --platform linux/amd64 -p 7777:7777/tcp -p 7777:7777/udp -d --name satisfactory-server --mount type=bind,source=${SS_SAVED},target=/home/steam/.config/Epic/FactoryGame --mount type=bind,source=${SS_CONFIG},target=/home/steam/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer -t satisfactory-server

shell:
	docker exec -it satisfactory-server /bin/bash

clean:
	docker image rm satisfactory-server
