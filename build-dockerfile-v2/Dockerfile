FROM mjvdende/python

RUN wget --no-check-certificate https://raw.githubusercontent.com/xebia/twc-cd-with-docker/master/app/helloWorld.py
ENV FLASK_APP helloWorld.py
CMD ["flask", "run", "--host=0.0.0.0"]
EXPOSE 5000
