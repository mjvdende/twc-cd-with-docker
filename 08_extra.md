<!-- .slide: data-background="#6B205E" -->
# Exercises: extra

!SUB
## Connect the dots
Build a working pipeline from the building blocks

Hints: Jenkins, Rundeck, post-receive hook?

!SUB
## Continuous Deployment
Deploy the image automatically to a production environment

!SUB
# running tomcat

```
# Start a tomcat container
$ DOCKER_ID=$(docker run -P -d <docker-hub-name>/tomcat7:v0.1)

# docker inspect show details about the container
$ docker inspect $DOCKER_ID

# Obtain mapped port of port 8080 of the container
$ PORT=$(docker port $DOCKER_ID 8080)

# access tomcat via mapped port
$ curl http://localhost:$PORT

# Obtain ip address of container
$ IPADDRESS=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $DOCKER_ID)

# http request on image IP address
$ curl http://$IPADDRESS:8080
```

!SUB
## Pipeline-in-a-box
We want to be host-agnostic

Run the Continuous Delivery Pipeline as a container itself

!SUB
## For the experts: multi-host
Make the pipeline work on a cluster of Docker hosts.

!SUB
# creating a farm of tomcat

```
count=0
TOMCAT_IPS=""

while [ $count -lt 5 ] ; do
  DOCKER_ID=$(docker run -P –d <docker-hub-name>/tomcat7:v0.1)
  IPADDRESS=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $DOCKER_ID)
  TOMCAT_IPS="$TOMCAT_IPS $IPADDRESS"
  count=$(($count + 1))
done

echo all tomcats : $TOMCAT_IPS
```
