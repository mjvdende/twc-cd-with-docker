<!-- .slide: data-background="#64217E" -->
<center>
# ![exercise](img/sprocket.png) <!-- .element: style="width: 10%; height: auto;" class="noborder" --> Exercise: Building an image using a Dockerfile

!SUB
# Dockerfile

`go-hello-world-http-v1/Dockerfile`
```dockerfile
FROM golang

RUN go get github.com/simonvanderveldt/go-hello-world-http
```

!SUB
# Build and run the image
```bash
$ docker build -t go-hello-world-http go-hello-world-http-v1
Sending build context to Docker daemon 2.048 kB
Step 1 : FROM golang
 ---> 002b233310bb
Step 2 : RUN go get github.com/simonvanderveldt/go-hello-world-http
 ---> Running in 1c4e7bf0833e
 ---> 8db642e96eed
Removing intermediate container 1c4e7bf0833e
Successfully built 8db642e96eed

# See what happened in each layer that our image exists of
$ docker history go-hello-world-http
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
91a8a211556f        13 minutes ago      /bin/sh -c #(nop)  EXPOSE 80/tcp                0 B
de2c1fef8d39        51 minutes ago      /bin/sh -c #(nop)  CMD ["/bin/sh" "-c" "/go/b   0 B
8db642e96eed        55 minutes ago      /bin/sh -c go get github.com/simonvanderveldt   5.708 MB
002b233310bb        12 days ago         /bin/sh -c #(nop)  COPY file:f6191f2c86edc9343  2.478 kB
<missing>           12 days ago         /bin/sh -c #(nop)  WORKDIR /go                  0 B

$ docker run -d -p 80:80 go-hello-world-http /go/bin/go-hello-world-http
8ce667efcb4b2d785b4805987b798130998d65e4c75daa7a60b354e04b314005
```

!SUB
# Check
What have we done thus far?

What can we improve?
- Automatically start our application when we run the container <!-- .element: class="fragment" -->
- Declare on which port our application runs <!-- .element: class="fragment" -->

!SUB
## Enhanced Dockerfile
`go-hello-world-http-v2/Dockerfile`
```dockerfile
FROM golang

RUN go get github.com/simonvanderveldt/go-hello-world-http

CMD /go/bin/go-hello-world-http
EXPOSE 80
```

!SUB
# Build and run the enhanced image
```
$ docker build -t go-hello-world-http go-hello-world-http-v2
Sending build context to Docker daemon 2.048 kB
Step 1 : FROM golang
 ---> 002b233310bb
Step 2 : RUN go get github.com/simonvanderveldt/go-hello-world-http
 ---> Using cache
 ---> 8db642e96eed
Step 3 : CMD /go/bin/go-hello-world-http
 ---> Running in 804dd7261841
 ---> de2c1fef8d39
Step 4 : EXPOSE 80
 ---> Running in 20a26363a989
 ---> 91a8a211556f
Removing intermediate container 20a26363a989
Successfully built 91a8a211556f

$ docker run -d -P go-hello-world-http-v2
3f0b7f4f2a92d7165a832c23f2bf3a1b675f18c4ac6c2a4b1e6ccefed310237f

$ docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                   NAMES
cc245603ef5c        go-hello-world-http-v2  "/bin/sh -c /go/bin/g"   3 seconds ago       Up 2 seconds        0.0.0.0:32768->80/tcp   desperate_jones
```

!SUB
# Check
What have we done thus far?

What can we improve?
```
docker images | grep go-hello-world-http-v2
> go-hello-world-http-v2 latest d31a90b28d50 2 minutes ago 675.3 MB
```
<!-- .element: class="fragment" -->
Get rid of the build tools.
<br>We don't need/want them during run-time <!-- .element: class="fragment" -->

!SUB
# Getting rid of build tools in our image
Solution: <span class="fragment">2 images</span>
- Builder <!-- .element: class="fragment" -->
- Application <!-- .element: class="fragment" -->

!SUB
## Builder image
`builder/Dockerfile`
```dockerfile
FROM golang

ENTRYPOINT ["go", "build"]

CMD ["."]
```

```bash
$ build -t builder builder
...
Successfully built 0dede3ca803b
```

!SUB
# Build the application using the builder image
```bash
# Get the sources
$ git clone https://github.com/simonvanderveldt/go-hello-world-http go-hello-world-http-v3/go-hello-world-http
Cloning into '/Users/simon/go-hello-world-http'...
...

# Build the application using the builder image
$ cd go-hello-world-http-v3
$ docker run --rm --volume $(pwd)/go-hello-world-http:/go/src/go-hello-world-http --volume $(pwd)/build:/go builder go-hello-world-http

# We now have a built application
$ ls -hl build/go-hello-world-http
-rwxr-xr-x  1 simon  staff   5.4M Sep 20 22:13 build/go-hello-world-http
```

!SUB
# Application image
`go-hello-world-http-v3/Dockerfile`
```dockerfile
FROM debian

COPY build/go-hello-world-http /go-hello-world-http

CMD /go-hello-world-http
EXPOSE 80
```

```bash
# Build the application image
docker build -t go-hello-world-http-v3 .

# Run the application image
docker run -d -p 80:80 go-hello-world-http-v3
```

!SUB
# Result
```bash
docker images | grep hello-world-http-v3
> go-hello-world-http-v2  latest  5db0534216f3  58 seconds ago  130.8 MB
```
