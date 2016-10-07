FROM alpine

RUN apk add --no-cache python py-pip \
 && pip install flask \
 && rm -rf /var/cache/apk/*

ENV FLASK_APP helloWorld.py

EXPOSE 5000

ADD helloWorld.py /helloWorld.py

CMD ["flask", "run", "--host=0.0.0.0"]
