# docker-lamp (archlinux based)
A simple and mostly automatic LAMP setup. Well, actually it is more like a LNMP, as I use nginx in favour of apache, but everybody uses the term and in this context I doubt there are many usecases where it matters.

It is based on arch as the base image is especially small and minimal (and I know arch way better than ubuntu/debian).

It will download the `arch/base` image, install nginx, php-fpm, mysqld and supervisor, configure them and make supervisor manage nginx, php-fpm and mysqld as systemd is not working within docker containers yet.

## Usage
Install the container using

    docker build -t <yourname>/lamp git://github.com/alexex/docker-lamp.git

Then run it using:

    docker run -d <yourname>/lamp

Mount your web app under `/srv/http` using docker's `-v` switch to make the container serve it up. Use `-p 80` to expose the container's port.

A real world example could look like this:

    docker run -d -p 80 -v /vagrant/app:/srv/http -name app <yourname>/lamp

In this one docker is run in a vagrant machine and the app is in the vagrant shared folder in `app`. It will then be served by nginx/php-fpm in the container. Run `docker ps` to find out which port was assigned on the host. By accessing `<host>:<assigned port>` on the browser, you will be able to access your app.

## Modify / Fork
If you need adjustments to configuration, rewrites or other stuff, you can fork my github repository and then build your fork by using the `docker build` command above. Just replace my repository with yours.

## Additional information
I have modified some configuration and most of the services to keep the setup as simple as possible without using systemd. As containers are one-purpose things everything just runs as root. You can check the sections below to find out what modifications I made where.

### mysql
* Access as root user with no password
* Override default installation
* Run as root

### `nginx.conf`
* Change user to root
* One server serving at localhost from /srv/http using php
* Added `daemon off` to enable control by supervisord
* All comments removed

### `php-fpm.conf`
* Change user to root
* Remove unnecessary settings & comments
* Besides: all settings still default

### `php.ini`
* Commented out open_basedir restriction
* Enabled mysql extension
