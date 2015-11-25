FROM ubuntu:15.10
MAINTAINER Stefan Berggren <nsg@nsg.cc>

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install build-essential git cmake \
	libwebkit2gtk-3.0-dev libgtksourceview-3.0-dev \
	valac libxml2-utils ruby-dev rubygems
RUN gem install fpm --no-ri --no-rdoc

RUN adduser --gecos FALSE --disabled-login build
USER build
WORKDIR /home/build

RUN git clone https://github.com/voldyman/MarkMyWords.git
WORKDIR /home/build/MarkMyWords

RUN mkdir -p /home/build/MarkMyWords/out/usr/

ADD Makefile /tmp/Makefile
CMD make -C /tmp deb
