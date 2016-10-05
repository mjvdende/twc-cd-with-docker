FROM alpine

RUN apk add --update curl bash && rm -rf /var/cache/apk/*

ADD test.sh /test.sh

RUN chmod +x /test.sh

ENTRYPOINT ["/test.sh"]
