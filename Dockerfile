FROM python:3-alpine

# Update
RUN apk update
RUN python -m pip install --upgrade pip

# Install app dependencies
RUN pip install -r requirements.txt
