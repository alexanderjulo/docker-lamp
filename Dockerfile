FROM ubuntu:latest
MAINTAINER Alexander Jung-Loddenkemper <alexander@julo.ch>
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y mysql-server nginx php
