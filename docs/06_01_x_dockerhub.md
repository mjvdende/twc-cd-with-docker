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

!SUB
# Deploy application to cloud VM

Use a **deploy** to automatically start **python-hello-world**
on a google cloud **vm**

- Save the **ssh-key** from the email in your **project**
- Add docker hub **username** and **ip** to deploy script
 - ```deploy/deploy.sh```  <!-- .element: class="code-single-line" -->
- Run deploy script

```bash
$ ./deploy/deploy.sh
```

!SUB

# Script explained

```bash
# build and push
docker build -t $DOCKER_HUB_USERNAME/python-hello-world build-dockerfile-v3
docker push $DOCKER_HUB_USERNAME/python-hello-world

# login to google cloud VM
ssh -i ssh-key core@$DOCKER_VM_IP << EOF

# pull latest image
docker pull $DOCKER_HUB_USERNAME/python-hello-world

# stop and remove old docker images. Keep it clean
docker stop web-app || true
docker rm web-app || true
docker rmi $DOCKER_HUB_USERNAME/python-hello-world:current || true

# tag latest as current
docker tag $DOCKER_HUB_USERNAME/python-hello-world:latest $DOCKER_HUB_USERNAME/python-hello-world:current

# start the web app
docker run -d --restart always --name web-app -p 80:5000 $DOCKER_HUB_USERNAME/python-hello-world:current
EOF
```
