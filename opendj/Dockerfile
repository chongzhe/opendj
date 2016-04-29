FROM java:8

MAINTAINER warren.strange@gmail.com

WORKDIR /opt

ADD opendj.zip /var/tmp/opendj.zip
RUN unzip /var/tmp/opendj.zip -d /opt/ && rm -fr /var/tmp/opendj.zip
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

WORKDIR /opt/opendj

# Creating instance.loc consolidates the writable directories under one root
# We also create the extensions directory
# The strategy is the create a skeleton DJ instance under the instances/template directory
# and use this template to instantiate a new persistent image.
RUN echo "/opt/opendj/data" > /opt/opendj/instance.loc  && \
    mkdir -p /opt/opendj/instances/template/lib/extensions

# Add a default setup script. This can get replaced by mounting a volume on /opt/opendj/boostrap
ADD setup.sh /opt/opendj/bootstrap/setup.sh


VOLUME /opt/opendj/bootstrap
VOLUME /opt/opendj/data


# Note -
#RUN /opt/opendj/setup --cli -p 389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate  --sampleData 5 --baseDN "dc=example,dc=com" -h localhost --rootUserPassword password --acceptLicense --no-prompt --doNotStart

EXPOSE 389 636 4444

ADD run.sh /opt/opendj/run.sh


CMD ["/opt/opendj/run.sh"]
