FROM java:8

MAINTAINER warren.strange@gmail.com

WORKDIR /opt

ADD opendj.zip /var/tmp/opendj.zip
RUN unzip /var/tmp/opendj.zip -d /opt/ && rm -fr /var/tmp/opendj.zip
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/


# Path to secret file that contains the cn=Directory Manager password
# Mount a docker volume or K8S secret volume on this
ENV DIR_MANAGER_PW_FILE /var/secrets/dirmanager.pw

WORKDIR /opt/opendj

# Creating instance.loc consolidates the writable directories under one root
# We also create the extensions directory
# We set a default password value here, but this is almost
# certainly not what you want.
RUN echo "/opt/opendj/data" > /opt/opendj/instance.loc  && \
    mkdir -p /opt/opendj/data/lib/extensions && \
    mkdir -p /var/secrets && \
    echo "password"  > /var/secrets/dirmanager.pw


ADD Dockerfile /

ADD bootstrap/ /opt/opendj/bootstrap/

EXPOSE 389 636 4444 8989

ADD run.sh /opt/opendj/run.sh


CMD ["/opt/opendj/run.sh"]
