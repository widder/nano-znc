FROM alpine
MAINTAINER Thibault NORMAND <me@zenithar.org>

WORKDIR /src

RUN apk add --update -t build-deps make gcc g++ git wget bison openssl-dev swig perl-dev python3-dev icu-dev \
    && apk add -u musl && rm -rf /var/cache/apk/* \
    && wget http://znc.in/releases/znc-1.6.0.tar.gz \
    && tar zxvf znc-1.6.0.tar.gz \
    && cd /src/znc-1.6.0 \
    && wget https://raw.githubusercontent.com/wired/colloquypush/683d4360d112fad1a741136049e105fad86a5e32/znc/colloquy.cpp -O modules/colloquy.cpp \
    && ./configure --prefix="/opt/znc" --enable-python --enable-perl \
    && make \
    && make install \
    && rm -Rf /src && apk del --purge build-deps \
    && apk add --update libstdc++ icu

RUN addgroup znc \
    && mkdir /data \
    && adduser -G znc -D -h /data znc \
    && chown -R znc:znc /opt/znc \
    && chown -R znc:znc /data

USER znc
WORKDIR /opt/znc

VOLUME /data

EXPOSE 6697
ENTRYPOINT ["/opt/znc/bin/znc"]
CMD ["--makeconf"]

