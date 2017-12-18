FROM registry.usef-dynamo.nl/usefdynamo/libsodium:0.7

MAINTAINER David Righart

ENV WILDFLY_VERSION 10.1.0.Final
ENV JBOSS_HOME /opt/jboss/wildfly

ADD VERSION .

RUN cd $HOME \
&& mkdir -p /opt/jboss/wildfly \
&& curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
&& tar xf wildfly-$WILDFLY_VERSION.tar.gz \
&& mv $HOME/wildfly-$WILDFLY_VERSION/* $JBOSS_HOME \
&& rm wildfly-$WILDFLY_VERSION.tar.gz

COPY postgresql $JBOSS_HOME/modules/

EXPOSE 8080
