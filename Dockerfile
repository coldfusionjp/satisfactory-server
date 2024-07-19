ARG SERVER_DIR="/home/steam/SatisfactoryDedicatedServer"

FROM --platform=linux/amd64 cm2network/steamcmd:latest AS satisfactory-server-temp
ARG SERVER_DIR

# setup environment
ENV CPU_MHZ=2500
ENV STEAM_APPID=1690800

# install the latest version of the dedicated server
RUN ${STEAMCMDDIR}/steamcmd.sh +force_install_dir ${SERVER_DIR} +login anonymous +app_update ${STEAM_APPID} -beta public validate +quit

# start from a fresh Debian 12 image
FROM --platform=linux/amd64 debian:bookworm
ARG SERVER_DIR

# create steam user and home directory
RUN addgroup --gid 1000 steam
RUN adduser --uid 1000 --gid 1000 --home /home/steam --disabled-password steam
RUN passwd -d steam

# copy over the dedicated server from our temp image
COPY --from=satisfactory-server-temp ${SERVER_DIR} ${SERVER_DIR}
RUN chown steam:steam ${SERVER_DIR}

# set user, workdir and entrypoint
USER steam
WORKDIR ${SERVER_DIR}
ENTRYPOINT [ "/bin/bash" ]
CMD [ "FactoryServer.sh" ]
