FROM base/arch
MAINTAINER Alexander Jung-Loddenkemper <alexander@julo.ch>

# update the system
RUN pacman -Syu --noconfirm
# install necessary software
RUN pacman -S mariadb nginx php-fpm supervisor --noconfirm --noscriptlet

# install custom config files
ADD nginx.conf /etc/nginx/nginx.conf
ADD php-fpm.conf /etc/php/php-fpm.conf
ADD php.ini /etc/php/php.ini
ADD supervisord.conf /etc/supervisord.conf

# setup mysql
RUN mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql/

# actually run the services
CMD ['supervisord -n']
