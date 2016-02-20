#!/bin/bash

#create a new user based on the user of your host OS. You pass this in as an ENV variable.
sudo useradd -ms /bin/bash ${USER_NAME}

sudo chown -R ${USER_NAME}:www-data /usr/local/app/
sudo chmod -R 777 /usr/local/app/
echo "mysql < /mysql_permissions.sql" >> /root/.bashrc #so that mysql can be accessed from host box

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf