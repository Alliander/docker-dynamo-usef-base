FROM jboss/base-jdk:8 as libsodium

LABEL author Dynamo

ENV LIBSODIUM_VERSION 1.0.11
ENV TZ=Europe/Amsterdam

USER root

#Create image to compile libsodium
RUN \                                                                                                            
        ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \                                                                                                                                
        yum -y update && yum clean all && \                                                                      
        yum -y install install curl && \                                                                         
        yum -y install make gcc gcc-c++ && \                                                                                                                                                                
        mkdir -p /tmpbuild/libsodium && \                                                                        
        cd /tmpbuild/libsodium && \                                                                              
        curl -L https://download.libsodium.org/libsodium/releases/old/libsodium-$LIBSODIUM_VERSION.tar.gz -o libsodium-$LIBSODIUM_VERSION.tar.gz && \                                                                             
        tar xfvz libsodium-$LIBSODIUM_VERSION.tar.gz && \                                                        
        cd /tmpbuild/libsodium/libsodium-$LIBSODIUM_VERSION/ && \                                                
        ./configure && \                                                                                         
        make && make check && \                                                                                  
        make install && \                                                                                        
        mv src/libsodium /usr/local/ && \                                                                        
        rm -Rf /tmpbuild/ && \                                                                                   
        yum -y remove --skip-broken gcc make gcc-c++ && \                                                        
        rm -rf /var/cache/yum && yum clean all 


# Final image for Wildfly    
FROM libsodium
ENV LIBSODIUM_VERSION 1.0.11
ENV TZ=Europe/Amsterdam
ENV WILDFLY_VERSION 10.1.0.Final
ENV JBOSS_HOME /opt/jboss/wildfly
LABEL author Dynamo

ADD VERSION .

RUN cd $HOME && \ 
    mkdir -p /opt/jboss/wildfly && \
    curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz && \
    tar xf wildfly-$WILDFLY_VERSION.tar.gz && \
    mv $HOME/wildfly-$WILDFLY_VERSION/* $JBOSS_HOME && \
    rm wildfly-$WILDFLY_VERSION.tar.gz

COPY postgresql $JBOSS_HOME/modules/

EXPOSE 8080
