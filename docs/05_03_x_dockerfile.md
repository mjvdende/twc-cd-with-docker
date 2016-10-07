<!-- .slide: data-background="#64217E" -->
<center>
# ![exercise](img/sprocket.png) <!-- .element: style="width: 10%; height: auto;" class="noborder" --> Exercise: Building an image using a Dockerfile

!SUB
# Dockerfile

Dockerfile for **Hello World** application

```dockerfile
FROM mjvdende/python

RUN wget --no-check-certificate https://raw.githubusercontent.com/xebia/twc-cd-with-docker/master/app/helloWorld.py
```


!SUB
# Build and run the image

```bash
$ docker build -t python-hello-world:1 build-dockerfile-v1
Sending build context to Docker daemon 2.048 kB
Step 1 : FROM mjvdende/python
 ---> 002b233310bb
Step 2 : RUN wget --no-check-certificate https://raw.githubusercontent.com/xebia/twc-cd-with-docker/master/app/helloWorld.py
 ---> Running in 1c4e7bf0833e
 ---> 8db642e96eed
Removing intermediate container 1c4e7bf0833e
Successfully built 8db642e96eed

# See what happened in each layer that our image exists of
$ docker history python-hello-world:1
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
6fd6432eede5        30 seconds ago      /bin/sh -c wget --no-check-certificate https:   289 B
3189826efed6        About an hour ago   /bin/sh -c #(nop)  CMD ["bash"]                 0 B
62eeacc844be        20 hours ago        /bin/sh -c apk add --no-cache python py-pip w   53.02 MB
ee4603260daa        9 days ago          /bin/sh -c #(nop) ADD file:d6ee3ba7a4d59b1619   4.803 MB

$ docker run -d -p 5000:5000 -e FLASK_APP=helloWorld.py python-hello-world:1 flask run --host=0.0.0.0
8ce667efcb4b2d785b4805987b798130998d65e4c75daa7a60b354e04b314005

$ docker stop 8ce
```

!SUB
# Check

**What have we done thus far?**
- Automated build of our docker image  <!-- .element: class="fragment" -->

**What can we improve?** <!-- .element: class="fragment" -->

- Automatically start our application when we run the container <!-- .element: class="fragment" -->
- Declare on which port our application runs <!-- .element: class="fragment" -->

!SUB
## Enhanced Dockerfile

**build-dockerfile-v2/Dockerfile**

```dockerfile
FROM mjvdende/python

EXPOSE 5000

ENV FLASK_APP helloWorld.py

RUN wget --no-check-certificate https://raw.githubusercontent.com/xebia/twc-cd-with-docker/master/app/helloWorld.py

CMD ["flask", "run", "--host=0.0.0.0"]
```

!SUB
# Build and run the enhanced image
```bash
$ docker build -t python-hello-world:2 build-dockerfile-v2
Sending build context to Docker daemon 2.048 kB
Step 1 : FROM mjvdende/python
 ---> 002b233310bb
Step 2 : RUN wget --no-check-certificate https://raw.githubusercontent.com/xebia/twc-cd-with-docker/master/app/helloWorld.py
 ---> Using cache
 ---> 8db642e96eed
Step 3 : CMD flask run --host=0.0.0.0
 ---> Running in 804dd7261841
 ---> de2c1fef8d39
Step 4 : EXPOSE 5000
 ---> Running in 20a26363a989
 ---> 91a8a211556f
Removing intermediate container 20a26363a989
Successfully built 91a8a211556f

$ docker run -d -P python-hello-world:2
3f0b7f4f2a92d7165a832c23f2bf3a1b675f18c4ac6c2a4b1e6ccefed310237f

$ docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                   NAMES
cc245603ef5c        go-hello-world-http-v2  "/bin/sh -c /go/bin/g"   3 seconds ago       Up 2 seconds        0.0.0.0:32768->80/tcp   desperate_jones
```

!SUB
# Check

**What can we improve?**

Get rid of the build tools <!-- .element: class="fragment" --> <br />
We don't need/want them during run-time

!SUB
# Getting rid of tools in our image

**build-dockerfile-v3/Dockerfile**

```dockerfile
FROM alpine

RUN apk add --no-cache python py-pip \
 && pip install flask \
 && rm -rf /var/cache/apk/*

EXPOSE 5000

ENV FLASK_APP helloWorld.py

ADD helloWorld.py /helloWorld.pys

CMD ["flask", "run", "--host=0.0.0.0"]
```

```bash
# Build the application image
$ docker build -t python-hello-world:3 build-dockerfile-v3

# Run the application image
$ docker run -d -p 5000:5000 python-hello-world:3
```

!SUB
# ![exercise](img/sprocket.png) <!-- .element: style="width: 10%; height: auto;" class="noborder" --> Extra Exercise

- Create a nodejs or java or anything application
- Compose a Dockerfile for it
- Try to create smallest docker image as possible
- Build and Run it
