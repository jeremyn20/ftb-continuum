# This is based on itzg/minecraft-server

FROM java:8

MAINTAINER Mattias-origin Kågström <mattias.kagstrom@hotmail.com>

ENV DOWNLOADLINK=https://media.forgecdn.net/files/2658/289/FTBContinuumServer_1.6.0.zip

RUN apt-get update && apt-get install -y wget unzip
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir -p /data && cd /data && \

        wget -c $DOWNLOADLINK -O FTBContinuumServer.zip && \
        unzip FTBContinuumServer.zip && \
        rm FTBContinuumServer.zip && \
        bash -x FTBInstall.sh && \
        echo 'eula=true' > eula.txt && \
        chown -R minecraft /data



USER minecraft

EXPOSE 25565

ADD /data/ServerStart.sh /start

VOLUME /data
WORKDIR /data

CMD /start

ENV MOTD A Minecraft (FTB Continuum Server) Server Powered by Docker
ENV LEVEL world
ENV JVM_OPTS -Xms4096m -Xmx4096m
