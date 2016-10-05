FROM alpine

RUN apk add --no-cache curl

ADD test.sh /test.sh

RUN chmod +x /test.sh

CMD /test.sh http://$SUT_PORT_80_TCP_ADDR:$SUT_PORT_80_TCP_PORT
