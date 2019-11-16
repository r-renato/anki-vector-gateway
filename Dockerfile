FROM debian:stretch

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y wget zlib1g-dev python3-pip \
        libatlas-base-dev \
        python3-pil.imagetk python3-numpy && \
    echo -e "\n--- Upgrading python to 3.7 ---\n" && \
    for n in $(whereis python3.5) ; do echo rm -f $n ; done && \
    wget -q https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz && \
    (tar xzf Python-3.7.2.tgz && rm Python-3.7.2.tgz && \
        cd Python-3.7.2 && ./configure --enable-optimizations && make altinstall) && \
    echo -e "\n--- ANKI VECTOR INSTALL ---\n" && python -V && python3 -V\
    python3 -m pip install --user anki_vector && \
#    python3 -m pip install --user --upgrade anki_vector && \
    rm -rf /var/lib/apt/lists/*

ADD app/ /app
WORKDIR /app

# Install app dependencies
#RUN pip3 install -r requirements.txt
