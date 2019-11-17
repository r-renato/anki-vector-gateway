FROM python:3.7-stretch as builder

LABEL maintainer="x" \
      stage=builder

# ENV LANG C.UTF-8

ADD app/ /app

RUN apt-get update && \
    apt-get install -y python3-pip \
        libatlas-base-dev \
        python3-pil.imagetk python3-numpy && \
    apt-get clean && \
    echo "\n--- Anki Vector SDK Install ---\n" \
    python3 -m pip install --user anki_vector && \
    python3 -m pip install --user anki_vector && \
    find / -name "anki_vector" 2>/dev/null && \
#    python3 -m pip install --user --upgrade anki_vector && \
    rm -rf /var/lib/apt/lists/* && \
    echo "--- Anki prerequisite installed well. ($(python3 -V)) ---\n" && \
    python3 -m pip install -r /app/requirements.txt

ENV PYTHONHOME /usr/local
ENV LD_LIBRARY_PATH /usr/local/lib

RUN python3 -c 'import anki_vector'