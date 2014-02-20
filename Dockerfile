MAINTAINER Alexander Jung-Loddenkemper <alexander@julo.ch>
FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y mysql-server nginx php
