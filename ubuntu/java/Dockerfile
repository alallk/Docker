# docker image build -t "ubuntu-jdk8:0.1" . && docker run -it ubuntu-jdk8:0.1 /bin/bash
FROM ubuntu:16.04

LABEL maintainer="Aristótenes Vilar Filho <alallk@msn.com>"

ENV DEBIAN_FRONTEND teletype \
JAVA_HOME /usr/lib/jvm/java-8-oracle \
LANG      en_US.UTF-8 \
LC_ALL    en_US.UTF-8

RUN apt-get --purge remove openjdk*
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update
RUN apt-get install -y --no-install-recommends locales
RUN locale-gen ${LANG}
RUN dpkg-reconfigure locales
RUN apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default
RUN apt-get clean all
