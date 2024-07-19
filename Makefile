all:
	docker build --platform linux/amd64 -t satisfactory-server .

run:
	@mkdir -p /mnt/home/falken/satisfactory/config
	@mkdir -p /mnt/home/falken/satisfactory/saved
	docker run --platform linux/amd64 -p 7777:7777/udp -p 15000:15000/udp -p 15777:15777/udp -d --name satisfactory-server --mount type=bind,source=/mnt/home/falken/satisfactory/saved,target=/home/steam/.config/Epic/FactoryGame --mount type=bind,source=/mnt/home/falken/satisfactory/config,target=/home/steam/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer -t satisfactory-server

shell:
	docker exec -it satisfactory-server /bin/bash

clean:
	docker image rm satisfactory-server
