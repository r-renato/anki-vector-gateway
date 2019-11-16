FROM debian:stretch as builder

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		bzip2 \
		dpkg-dev \
		file \
		g++ \
		gcc \
		imagemagick \
		libbz2-dev \
		libc6-dev \
		libcurl4-openssl-dev \
		libdb-dev \
		libevent-dev \
		libffi-dev \
		libgdbm-dev \
		libgeoip-dev \
		libglib2.0-dev \
		libgmp-dev \
		libjpeg-dev \
		libkrb5-dev \
		liblzma-dev \
		libmagickcore-dev \
		libmagickwand-dev \
		libncurses5-dev \
		libncursesw5-dev \
		libpng-dev \
		libpq-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libtool \
		libwebp-dev \
		libxml2-dev \
		libxslt-dev \
		libyaml-dev \
		make \
		patch \
		unzip \
		xz-utils \
		zlib1g-dev \
		\
# https://lists.debian.org/debian-devel-announce/2016/09/msg00000.html
		$( \
# if we use just "apt-cache show" here, it returns zero because "Can't select versions from package 'libmysqlclient-dev' as it is purely virtual", hence the pipe to grep
			if apt-cache show 'default-libmysqlclient-dev' 2>/dev/null | grep -q '^Version:'; then \
				echo 'default-libmysqlclient-dev'; \
			else \
				echo 'libmysqlclient-dev'; \
			fi \
		) \
	; \
rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

# extra dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
		tk-dev \
		uuid-dev \
		git \
        ca-certificates \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone  -b 3.7 --depth=1 https://github.com/python/cpython.git --single-branch
WORKDIR /opt/cpython
RUN ./configure
RUN make -j8
RUN make install -j8 && echo "\n--\n" && ls -latr /lib && echo "\n--\n" && ls -latr /usr/lib && echo "\n--\n"

FROM busybox:glibc

COPY --from=builder /usr/local/lib/python3.7 /usr/local/lib/python3.7
COPY --from=builder /usr/local/lib/libpython3.7m.a /usr/local/lib/
COPY --from=builder /usr/local/bin /usr/local/bin

#COPY --from=builder /lib/x86_64-linux-gnu/*.so.* /lib/
COPY --from=builder /lib/arm-linux-gnueabihf  /lib/
COPY --from=builder /usr/lib/*.so.* /usr/lib/

CMD ["/usr/local/bin/python3.7"]
