#!/bin/bash
DOCKER_HUB_USERNAME=mjvdende
DOCKER_VM_IP=104.199.25.253

docker build -t $DOCKER_HUB_USERNAME/python-hello-world .
docker push $DOCKER_HUB_USERNAME/python-hello-world

ssh core@$DOCKER_VM_IP << EOF
docker pull $DOCKER_HUB_USERNAME/python-hello-world
docker stop hello-world || true
docker rm hello-world || true
docker rmi $DOCKER_HUB_USERNAME/python-hello-world:current || true
docker tag $DOCKER_HUB_USERNAME/python-hello-world:latest $DOCKER_HUB_USERNAME/python-hello-world:current
docker run -d --restart always --name web -p 80:5000 $DOCKER_HUB_USERNAME/python-hello-world:current
EOF
