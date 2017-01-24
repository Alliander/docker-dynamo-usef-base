FROM drighart/libsodium:v1

ENV WILDFLY_VERSION 10.1.0.Final
ENV JBOSS_HOME /opt/jboss/wildfly

RUN cd $HOME \
&& curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
&& tar xf wildfly-$WILDFLY_VERSION.tar.gz \
&& mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
&& rm wildfly-$WILDFLY_VERSION.tar.gz

EXPOSE 8080
