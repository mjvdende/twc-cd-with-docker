<!-- .slide: data-background="#64217E" -->
<center>
# Test
![cd - deploy](img/auto-test-continuous-deployment-pipeline.png) <!-- .element: class="noborder" -->

!SUB
# Tests with Docker
- Run tests from tester container</span> <!-- .element: class="fragment" -->
- Artifact container is the System Under Test <!-- .element: class="fragment" -->

!SUB
# Dockerfile tester Docker image

**tester/Dockerfile**

```dockerfile
FROM alpine

RUN apk add --no-cache curl

ADD test.sh /test.sh

RUN chmod +x /test.sh

CMD /test.sh http://$SUT_PORT_80_TCP_ADDR:$SUT_PORT_80_TCP_PORT
```

!SUB
# Build tester Docker image

```bash
docker build -t tester tester
```

!SUB
# Run tests
```bash
docker run --link python-hello-world:3 tester
```

!SUB
# Test result
The test fails :(

Make the test pass!
