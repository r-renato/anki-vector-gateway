FROM python:3.7-stretch as builder

LABEL maintainer="x"
LABEL stage=builder

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y python3-pip \
        libatlas-base-dev \
        python3-pil.imagetk python3-numpy && \
    apt-get clean && \
#    echo -e "\n--- Upgrading python to 3.7 ---\n" && \
#    for n in $(whereis python3.5) ; do rm -Rf $n ; done && \
    echo "\n--- Anki Vector SDK Install ---\n" \
    python3 -m pip install --user anki_vector && \
#    python3 -m pip install --user --upgrade anki_vector && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Anki prerequisite installed well. Python3 v$(python3 -V)" && \
    python3 -m pip install -r app/requirements.txt

ENV PYTHONHOME /usr/local
ENV LD_LIBRARY_PATH /usr/local/lib
