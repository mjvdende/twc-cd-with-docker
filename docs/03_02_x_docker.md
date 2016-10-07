<!-- .slide: data-background="#64217E" -->
<center>
# ![exercise](img/sprocket.png) <!-- .element: style="width: 10%; height: auto;" class="noborder" --> Exercise: Docker first steps

!SUB
# Getting Started

Why not run docker **without** any **arguments?** Let's see what happens

```
$ docker
Usage: docker [OPTIONS] COMMAND [arg...]
       docker [ --help | -v | --version ]

A self-sufficient runtime for containers.

Options:

  --config=~/.docker              Location of client config files
  -D, --debug                     Enable debug mode
  -H, --host=[]                   Daemon socket(s) to connect to
  -h, --help                      Print usage
  -l, --log-level=info            Set the logging level
  --tls                           Use TLS; implied by --tlsverify
  --tlscacert=~/.docker/ca.pem    Trust certs signed only by this CA
  --tlscert=~/.docker/cert.pem    Path to TLS certificate file
  --tlskey=~/.docker/key.pem      Path to TLS key file
  --tlsverify                     Use TLS and verify the remote
  -v, --version                   Print version information and quit

Commands:
    attach    Attach to a running container
    build     Build an image from a Dockerfile
    commit    Create a new image from a container's changes
...
```

!SUB
# Getting Started

Show all **running** containers

```
$ docker ps
CONTAINER ID     IMAGE     COMMAND     CREATED     STATUS      PORTS      NAMES
```

!SUB
# Run a container

The **obligatory** hello world

```
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c04b14da8d14: Pull complete
Digest: sha256:0256e8a36e2070f7bf2d0b0763dbabdd67798512411de4cdcf9431a1feb60fd9
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

!SUB
## Run an interactive container

**Experiment** with a Docker **container**

```bash
# Pull in Jenkins Docker images from the Docker Hub
$ docker pull jenkins

# Start Docker container and start a interactive session in bash
$ docker run -ti jenkins bash
jenkins@d83aa96f567a:/# whoami
jenkins

# Which operating system is this?
jenkins@d83aa96f567a:/# uname -a
Linux 00cbdb571770 4.4.0-31-generic #50-Ubuntu SMP Wed Jul 13 00:07:12 UTC 2016 x86_64 GNU/Linux

# Is docker installed?
jenkins@d83aa96f567a:/# docker ps
bash: docker: command not found

# Exit Docker container
jenkins@d83aa96f567a:/# exit
```

!SUB
# Check. That wasn't so hard was it?
