About this example
------------------
This example Dockerfile will build a docker container with nginx installed and running.
Additionally, we're shipping a customer sites-available/default configuration file. Once
up and running, you will have a custom "Docker Basics Example" page with a custom
header: `X-Docker-Basics: DOCKER`

Finally, we're including a custom "document" root directory which contains our web
application. When we run the container, we will mount this volume within the container.


Building the container
----------------------
The following Docker build command creates the container image. Basically it makes sure your docker file is not doing anything crazy. It download Ubuntu and some of the other packages you will be installing. It does not fun the container.
```
 $ docker build -t docker-laravel:nginx-mysql .
```

Running the container
---------------------
The following Docker run command will get the container running with a published port and mounted
volumes in place:
```
 $ docker run --name cms -p 8080:80 -p 3306:3306 -e USER_NAME=`whoami` -v `pwd`/app:/usr/local/app:rw -v `pwd`/logs:/var/log/nginx:rw -d docker-laravel:nginx-mysql
```

Log into the terminal
----------------

```
$ docker exec -it cms bash
```


Testing the application
-------------
visit `http://localhost:8080/`


To start the container
----------------

```
$ sudo docker start cms
```

To stop the container
----------------

```
$ sudo docker stop cms
```

To restart the container
----------------

```
$ sudo docker restart cms
```

To delete the container
----------------
Deleting the container will delete any data inside the container. ie. the data in your db will not be preserved
```
$ sudo docker rm cms
```

To delete the image
----------------
Deleting the images means you will have to re-download Ubuntu and all the packages. Unless they are cached.
```
$ sudo docker rmi docker-laravel:nginx-mysql
```