FROM python:3-alpine

# Update
RUN apk update
RUN python -m pip install --upgrade pip
RUN apk --no-cache add --virtual .builddeps gcc gfortran musl-dev
RUN apk add --update --no-cache py3-numpy
ENV PYTHONPATH=/usr/lib/python3.7/site-packages

#RUN pip3 install numpy==1.14.0 && apk del .builddeps && rm -rf /root/.cache
RUN apk add py3-pillow
RUN apk add --update --no-cache anki-vector

ADD app/ /app
WORKDIR /app

# Install app dependencies
#RUN pip3 install -r requirements.txt
