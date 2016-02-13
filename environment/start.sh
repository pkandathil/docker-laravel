#!/bin/bash

#create a new user based on the user of your host OS. You pass this in as an ENV variable.
sudo useradd -ms /bin/bash ${USER_NAME}

sudo chown -R ${USER_NAME}:www-data /usr/local/app/
sudo chmod -R 777 /usr/local/app/
# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf
