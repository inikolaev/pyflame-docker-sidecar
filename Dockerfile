FROM alpine:latest

RUN apk add --no-cache libstdc++ perl
RUN apk add --no-cache --virtual .build-dependencies python2 python2-dev python3 python3-dev py-virtualenv g++ autoconf pkgconf automake libtool make git linux-headers

RUN git clone --single-branch --branch disable-line-numbers-flag https://github.com/inikolaev/pyflame.git \
    && cd /pyflame \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && cd / \
    && rm -rf /pyflame

RUN apk del .build-dependencies

RUN wget https://raw.githubusercontent.com/brendangregg/FlameGraph/master/flamegraph.pl \
    && chmod +x /flamegraph.pl \
    && mv /flamegraph.pl /usr/bin



