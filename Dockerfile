FROM java:8

MAINTAINER Mattias Kågström <mattias.kagstrom@hotmail.com>

ENV DOWNLOADLINK=https://media.forgecdn.net/files/2658/289/FTBContinuumServer_1.6.0.zip

RUN apt-get update && apt-get install -y wget unzip
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/feed-the-beast && cd /tmp/feed-the-beast && \
	
	wget -c DOWNLOADLINK -O FTBContinuumServer.zip && \
	unzip FTBContinuumServer.zip && \
	rm FTBContinuumServer.zip && \
	bash -x FTBInstall.sh && \
	chown -R minecraft /tmp/feed-the-beast


USER minecraft

EXPOSE 25565

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start

ENV MOTD A Minecraft (FTB Continuum Server) Server Powered by Docker
ENV LEVEL world
ENV JVM_OPTS -Xms4096m -Xmx4096m
