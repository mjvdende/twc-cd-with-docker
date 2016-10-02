FROM alpine
RUN apk add --no-cache python py-pip wget bash \
 && pip install flask \
 && rm -rf /var/cache/apk/*
