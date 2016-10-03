<!-- .slide: data-background="#64217E" -->
<center>
# ![exercise](img/sprocket.png) <!-- .element: style="width: 10%; height: auto;" class="noborder" --> Exercise: Build a Pipeline in Jenkins

!SUB
# Pipeline In Jenkins

**Start Jenkins**

```
docker run -d --name=jenkins -p 8080:8080 -p 50000:50000 -v $PWD/jenkins:/var/jenkins_home --env JAVA_OPTS="-Xmx2024m" jenkins
```

!SUB
test  
