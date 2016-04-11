#!/bin/bash

#create a new user based on the user of your host OS. You pass this in as an ENV variable.
sudo useradd -ms /bin/bash ${USER_NAME}
usermod -a -G www-data ${USER_NAME} #add the user to www-data. If files are created by gulp then they are accessible by the server

sudo chown -R ${USER_NAME}:www-data /usr/local/app/
sudo chmod -R 777 /usr/local/app/
echo "mysql < /mysql_permissions.sql" >> /root/.bashrc #so that mysql can be accessed from host box

ln -s /usr/bin/nodejs /usr/bin/node
cd /usr/local/app
npm install npm -g # Update npm to the latest version
npm install --global gulp
npm install

service mysqld restart
service php5-fpm restart;
nginx -g "daemon off;"
