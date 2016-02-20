FROM ubuntu:14.04

MAINTAINER prashant kandathil <prashant@techsamurais.com>

ENV DEBIAN_FRONTEND noninteractive

# mainline or stable
ENV NGINX_REPO      stable
ENV NGINX_VERSION   1.8.1-1+trusty0
ENV MYSQL_VERSION 5.5.47-0ubuntu0.14.04.1

# get add-apt-respository for repo bits
RUN apt-get -qq update && \
    apt-get -yf install software-properties-common

# install nginx mysql and composer
RUN add-apt-repository --yes ppa:nginx/${NGINX_REPO} && \
    apt-get -qq update && \
    apt-get -yf install nginx=${NGINX_VERSION} php5-fpm php5-cli php5-json libapache2-mod-php5 php5-mysql php5-curl supervisor mysql-server=${MYSQL_VERSION} mysql-client curl && \
    curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# copy nginx default sites available file
ADD environment/default /etc/nginx/sites-available/default
ADD environment/my.cnf /etc/mysql/
ADD environment/start.sh /
ADD environment/mysql_permissions.sql /
ADD environment/supervisord.conf /etc/supervisord.conf

#create a new user based on the user of your host OS. You pass this in as an ENV variable.
RUN chmod 775 /mysql_permissions.sql
RUN chmod 775 /start.sh


# export port 80 for nginx
EXPOSE 80
EXPOSE 3306

CMD ["/start.sh"]