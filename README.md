About this example
------------------
The purpose of this repository is to provide an all-in-one development envrionment for laravel using docker. This repository, 
is not super generalized or setup for production. It's suppose to be an alternative to homestead. We're including a custom "document" root directory which contains our web application. When we run the container, we will mount this volume within the container.

Building the container
----------------------
The following Docker build command creates the container image. Basically it makes sure your docker file is not doing anything crazy. It download Ubuntu and some of the other packages you will be installing. It does not fun the container.

If you want php 5.6
```
$ git checkout php-5.6
```

If you want php 7.0
```
$ git checkout php-7.0
```


```
 $ git checkout php-5.6
 $ docker build -t laravel:nginx-mysql .
```

Running the container
---------------------
*Download a copy of laravel and place it in the app folder*
The following Docker run command will get the container running with a published port and mounted
volumes in place:
```
 $ docker run --name laravel-app -p 8080:80 -p 3306:3306 -e USER_NAME=`whoami` -v `pwd`/app:/usr/local/app:rw -v `pwd`/logs:/var/log/nginx:rw -d laravel:nginx-mysql
```

Log into the terminal
----------------

```
$ docker exec -it laravel-app bash
```


Testing the application
-------------
visit `http://localhost:8080/`


To start the container
----------------

```
$ sudo docker start laravel-app
```

To stop the container
----------------

```
$ sudo docker stop laravel-app
```

To restart the container
----------------

```
$ sudo docker restart laravel-app
```

To delete the container
----------------
Deleting the container will delete any data inside the container. ie. the data in your db will not be preserved
```
$ sudo docker rm laravel-app
```

To delete the image
----------------
Deleting the images means you will have to re-download Ubuntu and all the packages. Unless they are cached.
```
$ sudo docker rmi laravel:nginx-mysql
```


Access mysql from the host machine
----------------
Even though the port has been exposed on the box. The permissions have not been granted to access mysql from anywhere. 
To active that run this command. A line has been added to the .bashrc to grant privs. Check for it in start.sh
```
$ sudo docker exec -it laravel-app bash
```

Run Gulp
---------------
Log in to the container

`$ docker exec -it laravel-app bash`

Switch the user to user on your host machine. It was created when the container was created

`$ sudo su <username>`

Navigate to the app directory in the container

`$ cd /usr/local/app`

Run Gulp

`$ gulp watch`
