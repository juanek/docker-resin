FROM ubuntu:18.04

ENV TZ=America/Argentina/Buenos_Aires

RUN apt-get update && apt-get -y install tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

#Install Open JDK 8
#build-essential to compile with gcc
#wget download caucho resin
RUN apt-get update \
    && apt-get -y install build-essential openjdk-8-jdk\
    && apt-get -y --no-install-recommends install \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

#Install Resin 4
ENV PATH_BASE=/opt/juanek
ENV PATH_RESIN=$PATH_BASE/resin
ENV RESIN_VER=4.0.65

RUN mkdir -p /opt/juanek
ADD http://caucho.com/download/resin-4.0.65.tar.gz .
RUN tar -vzxf resin-4.0.65.tar.gz
RUN mv resin-4.0.65 /opt/juanek/resin
RUN cd /opt/juanek/resin && ./configure --prefix=/opt/juanek/resin && make && make install
#delete resin-4.0.65 y resin-4.0.65.tar.gz

#resinctl generate-password my-user my-password >> /opt/juanek/resin/conf/resin.properties
RUN echo "admin_user: admin" >> /opt/juanek/resin/conf/resin.properties
RUN echo "admin_password: {SSHA}FR8bK6ych6QefuaAR1fUAckNurf8VhSw" >> /opt/juanek/resin/conf/resin.properties
RUN echo "web_admin_external: true" >> /opt/juanek/resin/conf/resin.properties
#RUN echo "admin_secure: true" >> /opt/juanek/resin/conf/resin.properties


#WebApp
#ADD ./resources/WebApp /opt/juanek/resin/webapps/WebApp

#RUN mkdir -p /usr/local/java
#RUN mkdir -p /opt/deploy
ENV PATH /opt/juanek/resin/bin:$PATH
CMD ["resinctl","start-with-foreground"]