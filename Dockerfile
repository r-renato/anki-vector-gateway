FROM python:3-alpine

# Update
RUN apk update
RUN python -m pip install --upgrade pip
RUN python -m pip install --upgrade pip3
RUN pip3 install --upgrade python3-pil.imagetk &&/
    pip3 install --upgrade python3-numpy

ADD app/ /app
WORKDIR /app

# Install app dependencies
RUN pip install -r requirements.txt
