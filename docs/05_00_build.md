<!-- .slide: data-background="#64217E" -->
<center>
# Build
![cd - build](img/build-continuous-deployment-pipeline.png) <!-- .element: class="noborder" -->

!SUB
## Build workflow
- Get the application sources <!-- .element: class="fragment" -->
- Build the application/artifact <!-- .element: class="fragment" --> <span class="fragment">-> The Docker image is the artifact</span>

!SUB
## Docker Images

<div style="position: absolute; right: 0; top:100; width: 25%; height: auto;"><img src="img/docker-image.png"/></div>
- Contain everything needed to run the app
- Are portable across daemons
- Are created using a simple DSL
- Can be shared by pushing them to an artifact store
