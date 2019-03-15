# docker image build -t "ubuntu-jdk8:0.1" . && docker run -it ubuntu-jdk8:0.1 /bin/bash
FROM ubuntu:16.04

LABEL MAINTAINER Aristótenes Vilar <aristotenes.vilar@virtus.ufcg.edu.br> <https://virtus.ufcg.edu.br/)

ENV DEBIAN_FRONTEND teletype \
JAVA_HOME /usr/lib/jvm/java-8-oracle \
LANG      en_US.UTF-8 \
LC_ALL    en_US.UTF-8

RUN apt-get --purge remove openjdk* && \
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen ${LANG} && \
  dpkg-reconfigure locales && \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
  apt-get clean all && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

CMD ["bash"]
