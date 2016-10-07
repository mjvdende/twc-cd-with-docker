FROM alpine

RUN apk add --no-cache python py-pip \
 && pip install flask \
 && rm -rf /var/cache/apk/*

ADD helloWorld.py /helloWorld.py

ENV FLASK_APP helloWorld.py

CMD ["flask", "run", "--host=0.0.0.0"]

EXPOSE 5000
