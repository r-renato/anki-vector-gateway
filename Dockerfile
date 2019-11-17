FROM python:3.7-stretch as builder

FROM busybox:glibc

COPY --from=builder /usr/local/lib/python3.7 /usr/local/lib/python3.7
COPY --from=builder /usr/local/lib/libpython3.7m.a /usr/local/lib/
COPY --from=builder /usr/local/bin /usr/local/bin

#COPY --from=builder /lib/x86_64-linux-gnu/*.so.* /lib/
COPY --from=builder /lib/arm-linux-gnueabihf/*.so.*  /lib/
COPY --from=builder /usr/lib/*.so.* /usr/lib/

ENV PYTHONHOME /usr/local
ENV LD_LIBRARY_PATH /usr/local/lib

CMD ["echo -e \"\n--- ANKI VECTOR INSTALL ---\n\" && python -V && python3 -V"]
CMD ["/usr/local/bin/python3.7"]

#FROM debian:stretch as builder
#
#RUN set -ex; \
#	apt-get update; \
#	apt-get install -y --no-install-recommends \
#		autoconf \
#		automake \
#		bzip2 \
#		dpkg-dev \
#		file \
#		g++ \
#		gcc \
#		imagemagick \
#		libbz2-dev \
#		libc6-dev \
#		libcurl4-openssl-dev \
#		libdb-dev \
#		libevent-dev \
#		libffi-dev \
#		libgdbm-dev \
#		libgeoip-dev \
#		libglib2.0-dev \
#		libgmp-dev \
#		libjpeg-dev \
#		libkrb5-dev \
#		liblzma-dev \
#		libmagickcore-dev \
#		libmagickwand-dev \
#		libncurses5-dev \
#		libncursesw5-dev \
#		libpng-dev \
#		libpq-dev \
#		libreadline-dev \
#		libsqlite3-dev \
#		libssl-dev \
#		libtool \
#		libwebp-dev \
#		libxml2-dev \
#		libxslt-dev \
#		libyaml-dev \
#		make \
#		patch \
#		unzip \
#		xz-utils \
#		zlib1g-dev \
#		\
## https://lists.debian.org/debian-devel-announce/2016/09/msg00000.html
#		$( \
## if we use just "apt-cache show" here, it returns zero because "Can't select versions from package 'libmysqlclient-dev' as it is purely virtual", hence the pipe to grep
#			if apt-cache show 'default-libmysqlclient-dev' 2>/dev/null | grep -q '^Version:'; then \
#				echo 'default-libmysqlclient-dev'; \
#			else \
#				echo 'libmysqlclient-dev'; \
#			fi \
#		) \
#	; \
#rm -rf /var/lib/apt/lists/*
#
#ENV LANG C.UTF-8
#
## extra dependencies
#RUN apt-get update && apt-get install -y --no-install-recommends \
#		tk-dev \
#		uuid-dev \
#		git \
#        ca-certificates \
#    && rm -rf /var/lib/apt/lists/* \
#    && for n in $(whereis python3.5) ; do rm -Rf $n ; done
#
#WORKDIR /opt
#
#RUN git clone  -b 3.7 --depth=1 https://github.com/python/cpython.git --single-branch \
#    && (cd cpython && ./configure && make -j8 && make install -j8)
#RUN echo "\n--- Installing Anki Vector Prerequisite ---\n" \
#    && apt-get update && apt install -y python3-pip \
#    && apt-get install -y libatlas-base-dev \
#            python3-pil.imagetk python3-numpy
##    && echo "\n--- Installing Anki Vector ---\n" \
##    && python3 -m pip install --user anki_vector
#
##WORKDIR /opt/cpython
##RUN ./configure
##RUN make -j8
##RUN make install -j8 # && echo "\n--\n" && ls -latr /lib && echo "\n--\n" && ls -latr /usr/lib && echo "\n--\n"
#
#FROM busybox:glibc
#
#COPY --from=builder /usr/local/lib/python3.7 /usr/local/lib/python3.7
#COPY --from=builder /usr/local/lib/libpython3.7m.a /usr/local/lib/
#COPY --from=builder /usr/local/bin /usr/local/bin
#
##COPY --from=builder /lib/x86_64-linux-gnu/*.so.* /lib/
#COPY --from=builder /lib/arm-linux-gnueabihf/*.so.*  /lib/
#COPY --from=builder /usr/lib/*.so.* /usr/lib/
#
#CMD ["/usr/local/bin/python3.7"]
