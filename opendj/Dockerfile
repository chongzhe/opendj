FROM java:8

MAINTAINER warren.strange@gmail.com

WORKDIR /opt

ADD opendj.zip /var/tmp/opendj.zip
RUN unzip /var/tmp/opendj.zip -d /opt/ && rm -fr /var/tmp/opendj.zip
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

WORKDIR /opt/opendj

# Creating instance.loc consolidates the writable directories under one root
# We also create the extensions directory
RUN echo "/opt/opendj/data" > /opt/opendj/instance.loc  && \
    mkdir -p /opt/opendj/data/lib/extensions

# Add a default setup script. This can get replaced by mounting a volume on /opt/opendj/boostrap
ADD setup.sh /opt/opendj/bootstrap/setup.sh

COPY Dockerfile /

EXPOSE 389 636 4444

ADD run.sh /opt/opendj/run.sh


CMD ["/opt/opendj/run.sh"]
