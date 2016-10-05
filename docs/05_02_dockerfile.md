<!-- .slide: data-background="#64217E" -->
<center>
#Dockerfile
![Docker logo](img/docker-logo-no-text.png) <!-- .element: class="noborder" -->

!SUB
# Simple DSL for Dockerfile
Simple DSL to describe how to build an image</p>

```
# Comment
INSTRUCTION arguments
```

<p style="clear: both;"><br/>See <a href="https://docs.docker.com/engine/reference/builder/">https://docs.docker.com/engine/reference/builder/</a></p>

!SUB
## Instructions
- FROM
- COPY
- RUN
- CMD
- EXPOSE
- ENV
- And more

!SUB
## FROM
- Syntax: `FROM <image>:<tag>`
- Sets the base image for this image
- FROM must be the first non-comment instruction in the dockerfile

!SUB
## COPY
- Syntax:
  - `COPY <source> <destination>`
  - `COPY ["<source>", "<destination>"]`
- Copies files from the local machine into the image

!SUB
## RUN
- Syntax: `RUN <command>`
- Runs the specified command, and commits the result to the image
- RUN can be used multiple times

!SUB
## CMD
- Syntax:
  - `CMD command param1 param2`
  - `CMD ["executable", "param1", "param2"]`
- Provides defaults when executing a container
- CMD can only be used *one* time

!SUB
## EXPOSE
- Syntax: `EXPOSE <port>`
- Defines which ports to expose

!SUB
## ENV
- Syntax: `<key> <value>`
- Sets environment variables in the image
