FROM ubuntu:16.04
MAINTAINER Stijn Opheide <stijn@panenka76.com>

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

EXPOSE 22

COPY sshd_config /etc/ssh/sshd_config
COPY start.sh /opt/start.sh

ENTRYPOINT /opt/start.sh