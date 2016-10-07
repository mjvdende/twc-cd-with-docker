<!-- .slide: data-background="#64217E" -->
<center>
# Deploy

![cd - deploy](img/deploy-continuous-deployment-pipeline.png) <!-- .element: class="noborder" -->

!SUB
# Deployment workflow
- Store the build artifact in an artifact store <!-- .element: class="fragment" -->
- Get the build artifact from the artifact store and run it where we want it to run <!-- .element: class="fragment" -->

!SUB
## Docker hub
<div style="position: absolute; right: 0; top:100; width: 40%; height: auto;"><img src="img/docker-hub.png"/></div>
- Docker's own (public) artifact store
- Contains Docker images
  - Official/upstream images
  - Your own images
- Images can be private
- Can automatically build `Dockerfile`s
