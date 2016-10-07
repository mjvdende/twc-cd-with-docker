#!/bin/bash
DOCKER_HUB_USERNAME=<USERNAME>
# NOTE: not needed when deploying locally
CLOUD_VM_IP=<IP>

docker build -t $DOCKER_HUB_USERNAME/python-hello-world build-dockerfile-v3
docker push $DOCKER_HUB_USERNAME/python-hello-world

# login to google cloud VM (NOTE: Remove from script when deploying locally)
ssh -i ssh-key core@$DOCKER_VM_IP << EOF
docker pull $DOCKER_HUB_USERNAME/python-hello-world
docker stop web-app || true
docker rm web-app || true
docker rmi $DOCKER_HUB_USERNAME/python-hello-world:current || true
docker tag $DOCKER_HUB_USERNAME/python-hello-world:latest $DOCKER_HUB_USERNAME/python-hello-world:current
docker run -d --restart always --name web-app -p 8888:5000 $DOCKER_HUB_USERNAME/python-hello-world:current
# (NOTE: Remove from script when deploying locally)
EOF
