FROM python:3-alpine

# Update
RUN apk update
RUN apk --no-cache add --virtual .builddeps gcc &&/
    pip install numpy==1.14.0 &&/
    apk del .builddeps &&/
    rm -rf /root/.cache
RUN apk add py3-pillow

RUN python -m pip install --upgrade pip

ADD app/ /app
WORKDIR /app

# Install app dependencies
RUN pip3 install -r requirements.txt
