FROM usefdynamo/libsodium:0.1

MAINTAINER David Righart

ENV WILDFLY_VERSION 10.1.0.Final
ENV JBOSS_HOME /opt/jboss/wildfly

RUN cd $HOME \
&& curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
&& tar xf wildfly-$WILDFLY_VERSION.tar.gz \
&& mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
&& rm wildfly-$WILDFLY_VERSION.tar.gz

#TODO: remove h2 stuff below
RUN rm -Rf $JBOSS_HOME/modules/system/layers/base/com/h2database/*
COPY h2database $JBOSS_HOME/modules/system/layers/base/com/h2database/

COPY postgresql $JBOSS_HOME/modules/

EXPOSE 8080
