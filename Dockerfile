FROM alpine:3.10

ARG JQ_VERSION=1.7

RUN apk --no-cache --virtual build add \
  flex bison libtool make automake autoconf \
  oniguruma-dev build-base git

COPY . /app

WORKDIR /app

RUN autoreconf -fi \
  && ./configure --disable-valgrind --enable-all-static --prefix=/usr/local \
    --with-oniguruma --disable-docs --disable-maintainer-mode \
  && make -j8 && make install \
  && apk del build

ENTRYPOINT ["/usr/local/bin/jq"]
CMD []

