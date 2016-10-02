<!-- .slide: data-background="#64217E" -->
<center>
# ![exercise](img/sprocket.png) <!-- .element: style="width: 10%; height: auto;" class="noborder" -->  Exercise: Building an image

!SUB
# Build the application
```bash
$ docker run -ti golang bash
root@1cb333018404:/go#
# Now we're inside the container!

# Build the application
root@1cb333018404:/go# go get github.com/simonvanderveldt/go-hello-world-http

# Exit the container
root@1cb333018404:/go# exit
# Now we're outside the container again
```

!SUB
# Layers advantage: track what's changed
```bash
# Show the last container that was created
$ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
1cb333018404        golang              "bash"              3 minutes ago       Exited (0) 13 seconds ago                       clever_fermi

# Show our changes
$ docker diff <CONTAINER ID>
C /go
C /go/bin
A /go/bin/go-hello-world-http
C /go/src
A /go/src/github.com
A /go/src/github.com/simonvanderveldt
A /go/src/github.com/simonvanderveldt/go-hello-world-http
A /go/src/github.com/simonvanderveldt/go-hello-world-http/.git
...
```

!SUB
# Create the image
```bash
# Now create an image from our container
$ docker commit <CONTAINER ID> go-hello-world-http
sha256:34d091010050c9e94de643af60b4196dc132ad6f20825d779ab70bccf1f732b0

# Verify the image was created
$ docker images
REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
go-hello-world-http                  latest              34d091010050        14 seconds ago      675.4 MB

# See what happened in each layer that our image exists of
$ docker history go-hello-world-http
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
62484befa0e3        10 seconds ago      bash                                            5.708 MB
002b233310bb        12 days ago         /bin/sh -c #(nop) COPY file:f6191f2c86edc9343   2.478 kB
<missing>           12 days ago         /bin/sh -c #(nop)  WORKDIR /go                  0 B
<missing>           12 days ago         /bin/sh -c mkdir -p "$GOPATH/src" "$GOPATH/bi   0 B
...
```

!SUB
# Create a container from the image
```bash
$ docker run -d -p 80:80 go-hello-world-http /go/bin/go-hello-world-http

# Check that the container is running
$ docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED              STATUS              PORTS                NAMES
491462e89e35        go-hello-world-http   "/go/bin/go-hello-wor"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   admiring_spence

# Check if the application works
$ curl localhost
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
CONTAINER ID        IMAGE                 COMMAND                  CREATED              STATUS              PORTS                NAMES
491462e89e35        go-hello-world-http   "/go/bin/go-hello-wor"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   admiring_spence

# Remove the container
$ docker rm <CONTAINER ID>

# Check that the container no longer exists
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                    PORTS               NAMES
```

!SUB
# Check
What have we done thus far?

What can we improve?
- Automate the steps to build the image <!-- .element: class="fragment" -->
