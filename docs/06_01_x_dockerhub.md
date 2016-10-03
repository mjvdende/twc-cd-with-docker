<!-- .slide: data-background="#64217E" -->
<center>
# ![exercise](img/sprocket.png) <!-- .element: style="width: 10%; height: auto;" class="noborder" --> Exercise: Development Workflow

!SUB
# Push your image to the Docker Hub

Create a Docker Hub account at https://hub.docker.com

```bash
# tag docker image with docker hub username
$ docker tag python-hello-world:3 <USERNAME>/python-hello-world:3

# Login at docker hub
$ docker login
$ docker push <DOCKER HUB USERNAME>/python-hello-world:3
```
