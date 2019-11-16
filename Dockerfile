FROM python:3-alpine

# Update
RUN apk update
RUN apk add py3-pillow
RUN python -m pip install --upgrade pip

ADD app/ /app
WORKDIR /app

# Install app dependencies
RUN pip3 install -r requirements.txt
