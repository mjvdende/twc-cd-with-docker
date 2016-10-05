<!-- .slide: data-background="#64217E" -->
<center>
# ![exercise](img/sprocket.png) <!-- .element: style="width: 10%; height: auto;" class="noborder" -->  Exercise: Building an image

!SUB
# Build the application
```bash
$ docker run -ti mjvdende/python
bash-4.3#
# Now we're inside the container!

# Download the application
bash-4.3# wget --no-check-certificate https://raw.githubusercontent.com/xebia/twc-cd-with-docker/master/app/helloWorld.py

# Exit the container
bash-4.3# exit
# Now we're outside the container again
```

!SUB
# Layers advantage: track what's changed
```bash
# Show the last container that was created
$ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                       PORTS               NAMES
ec05e076eae1        mjvdende/python     "bash"              3 minutes ago       Exited (130) 5 seconds ago                       silly_tesla

# Show our changes
$ docker diff <CONTAINER ID>
A /helloWorld.py
C /root
A /root/.bash_history
A /root/.wget-hsts
```

!SUB
# Create the image
```bash
# Now create an image from our container
$ docker commit <CONTAINER ID> python-hello-world
sha256:60e7adf22eb516fd9d42c6624e819d559bc9625f5b2579f9e5d02fa51af06681

# Verify the image was created
$ docker images
REPOSITORY                          TAG                 IMAGE ID            CREATED             SIZE
python-hello-world                  latest              60e7adf22eb5        37 seconds ago      57.85 MB

# See what happened in each layer that our image exists of
$ docker history python-hello-world
IMAGE               CREATED              CREATED BY                                      SIZE                COMMENT
60e7adf22eb5        About a minute ago   bash                                            33.52 kB            
eb20866c1084        11 minutes ago       /bin/sh -c #(nop)  CMD ["bash"]                 0 B                 
<missing>           11 minutes ago       /bin/sh -c apk add --no-cache python py-pip w   53.02 MB            
<missing>           9 days ago           /bin/sh -c #(nop) ADD file:d6ee3ba7a4d59b1619   4.803 MB
...
```

!SUB
# Create a container from the image
```bash
$ docker run -d -p 5000:5000 -e FLASK_APP=helloWorld.py python-hello-world flask run --host=0.0.0.0

# Check that the container is running
$ docker ps
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                    NAMES
f69695235a11        python-hello-world   "flask run --host=0.0"   2 minutes ago       Up 2 minutes        0.0.0.0:5000->5000/tcp   drunk_bhabha

# Check if the application works
$ curl localhost:5000
> Hello, world!
```

!SUB
# Cleanup
```bash
# Stop the container
$ docker stop <CONTAINER ID>

# Check that the container is no longer running
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

!SUB
# Proper cleanup
Stopped containers are not automatically removed!

```bash
# Check that the container actually still exists
$ docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS                       PORTS               NAMES
f69695235a11        python-hello-world   "flask run --host=0.0"   3 minutes ago       Exited (137) 5 seconds ago                       drunk_bhabha

# Remove the container
$ docker rm <CONTAINER ID>

# Check that the container no longer exists
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                    PORTS               NAMES
```

!SUB
# Check

**What have we done thus far?**
- Manual build of the Docker image  <!-- .element: class="fragment" -->

**What can we improve?** <!-- .element: class="fragment" -->
- Automate the steps to build the image  <!-- .element: class="fragment" -->
