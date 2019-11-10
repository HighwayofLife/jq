FROM alpine:3.10

RUN apk --no-cache --virtual build add \
  flex bison libtool make automake autoconf \
  oniguruma build-base

COPY . /app

WORKDIR /app

RUN autoreconf -fi \
  && ./configure --with-oniguruma --disable-docs --disable-maintainer-mode \
    --disable-valgrind --enable-all-static --prefix=/usr/local \
  && make -j8 && make install \
  && apk del build

ENTRYPOINT ["/usr/local/bin/jq"]
CMD []

