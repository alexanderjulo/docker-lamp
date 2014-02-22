# docker-lamp (ubuntu based)
A simple and mostly automatic LAMP setup. Well, actually it is more like a LNMP, as I use nginx in favour of apache, but everybody uses the term and in this context I doubt there are many usecases where it matters.

It is based on phusion's base docker image, as it takes care of service managment for me and is fine in terms of size.

It will download the `phusion/baseimage` image, install nginx, php-fpm and mysqld, configure them and install service scripts for runit to start them.

**For a more detailed guide to setting up dev environments with docker, check out [my blog post](https://julo.ch/blog/docker-dev-environment)**

## Usage
You can either just pull the image from the docker index using:

    docker pull alexanderjulo/lamp

or you can build the image yourself, using

    docker build --rm -t <yourname>/lamp git://github.com/alexex/docker-lamp.git

I do not guarantee that the version on the docker index is up-to-date at all times, but it should be at most. If you want to be sure or are sure that it is not up-to-date build the image yourself (it's really quick, too).

Run a container with the new image using:

    docker run -d <yourname>/lamp

Or
    
    docker run -d alexanderjulo/lamp

If you just

Mount your web app under `/srv/http` using docker's `-v` switch to make the container serve it up. Use `-p 80` to expose the container's port.

A real world example could look like this:

    docker run -d -p 80 -v /vagrant/app:/srv/http -name app <yourname>/lamp

In this one docker is run in a vagrant machine and the app is in the vagrant shared folder in `app`. It will then be served by nginx/php-fpm in the container. Run `docker ps` to find out which port was assigned on the host. By accessing `<host>:<assigned port>` on the browser, you will be able to access your app.

## Modify / Fork
If you need adjustments to configuration, rewrites or other stuff, you can fork my github repository and then build your fork by using the `docker build` command above. Just replace my repository with yours.

If you are happy to have your changes locally you can just run an image and commit the container changes to a new image or a new tag on the same image. Whatever your prefer. This approach is the only valid if you need data volumes to work.

## Additional information
I have modified some configuration and most of the services to keep the setup as simple as possible without using systemd. As containers are one-purpose things everything just runs as root. You can check the sections below to find out what modifications I made where.

### mysql
* Access as root user with no password

### `nginx.conf`
* One server serving at localhost from /srv/http using php
* Added `daemon off` to enable control by runit
* All comments removed

### `php-fpm.conf`
* Added `daemonize off` to enable control by runit
* Remove unnecessary settings & comments
* Besides: all settings still default

### `php.ini`
* Commented out open_basedir restriction
* Enabled mysql extension
