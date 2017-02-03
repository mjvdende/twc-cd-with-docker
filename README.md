# Workshop Continuous Delivery with Docker

See http://xebia.github.io/twc-cd-with-docker/ for the slides

## Run pesentation locally 

```
cd docs && docker run -ti -d \
-p 8989:80 \
-v $(pwd):/usr/share/nginx/html:ro \
nginx
```
