FROM ubuntu:latest
MAINTAINER Alexander Jung-Loddenkemper <alexander@julo.ch>
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y mysql-server nginx php
