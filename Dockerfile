FROM alpine:edge
MAINTAINER widder <widder512@yahoo.de>

WORKDIR /src

RUN echo "Build..."

RUN echo "build2"
RUN apk update
RUN apk add --update -t build-deps make gcc g++ git wget bison openssl-dev swig perl-dev python3-dev icu-dev \
    && apk add -u musl && rm -rf /var/cache/apk/* \
    && wget http://znc.in/releases/znc-1.6.0.tar.gz \
    && tar zxvf znc-1.6.0.tar.gz \
    && cd /src/znc-1.6.0 \
    && wget https://raw.githubusercontent.com/wired/colloquypush/683d4360d112fad1a741136049e105fad86a5e32/znc/colloquy.cpp -O modules/colloquy.cpp \
    && wget https://raw.githubusercontent.com/jpnurmi/znc-playback/master/playback.cpp -O modules/playback.cpp \
    && ./configure --prefix="/opt/znc" \
#    && ./configure --prefix="/opt/znc" --enable-python --enable-perl \
    && make \
    &&  make install \
    && rm -Rf /src && apk del --purge build-deps \
    && apk add --update libstdc++ icu \
    && addgroup znc \
    && mkdir /data \
    && adduser -u 5959 -G znc -D -h /data znc \
    && chown -R znc:znc /opt/znc \
    && chown -R znc:znc /data


#disable ipv6
RUN echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.eth0.disable_ipv6 = 1" >> /etc/sysctl.conf

# install ca-certificates for colloquy to connect to colloquy.mobi
# or trusted irc servers
RUN apk update && apk add --update openssl ca-certificates

USER znc
WORKDIR /opt/znc

VOLUME /data

EXPOSE 6697
ENTRYPOINT ["/opt/znc/bin/znc"]
CMD ["-f"]
