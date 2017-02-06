FROM usefdynamo/libsodium

MAINTAINER David Righart

ENV WILDFLY_VERSION 10.1.0.Final
ENV JBOSS_HOME /opt/jboss/wildfly

RUN cd $HOME \
&& curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
&& tar xf wildfly-$WILDFLY_VERSION.tar.gz \
&& mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
&& rm wildfly-$WILDFLY_VERSION.tar.gz

RUN rm -Rf $JBOSS_HOME/modules/system/layers/base/com/h2database/*
COPY h2database $JBOSS_HOME/modules/system/layers/base/com/h2database/

EXPOSE 8080
