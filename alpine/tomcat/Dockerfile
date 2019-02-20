FROM alallk/alpine-oracle-jdk
#docker image build -t "alpine-tomcat:latest" . && docker run -d alpine-tomcat:latest
LABEL maintainer="Aristótenes Vilar Filho <alallk@msn.com>"

ENV TOMCAT_MAJOR_VERSION='8' \
TOMCAT_MINOR_VERSION='5' \ 
TOMCAT_BUG_FIX_VERSION='38' \
TOMCAT_URL_BASE_MIRROR='http://apache.mirrors.ionfish.org'
ENV TOMCAT_HOME=/opt/apache-tomcat-${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}.${TOMCAT_BUG_FIX_VERSION}
ENV PATH=${PATH}:${TOMCAT_HOME}/bin

RUN wget -q -O /tmp/tomcat.tar.gz ${TOMCAT_URL_BASE_MIRROR}/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}.${TOMCAT_BUG_FIX_VERSION}/bin/apache-tomcat-${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}.${TOMCAT_BUG_FIX_VERSION}.tar.gz && \
tar -xzf /tmp/tomcat.tar.gz -C /opt

CMD ["-c", "catalina.sh run"]
EXPOSE 8080
ENTRYPOINT [ "/bin/sh" ]