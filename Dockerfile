FROM python:3-alpine

# Update
RUN apk update
RUN apk add python3-pil.imagetk
RUN python -m pip install --upgrade pip
RUN pip3 install --upgrade python3-numpy

ADD app/ /app
WORKDIR /app

# Install app dependencies
RUN pip install -r requirements.txt
