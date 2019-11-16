FROM debian:stretch

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y python3-pip \
        libatlas-base-dev \
        python3-pil.imagetk python3-numpy && echo -e "\n--- ANKI VECTOR INSTALL ---\n" && \
    python3 -m pip install --user anki_vector && \
#    python3 -m pip install --user --upgrade anki_vector && \
    rm -rf /var/lib/apt/lists/*

ADD app/ /app
WORKDIR /app

# Install app dependencies
#RUN pip3 install -r requirements.txt
