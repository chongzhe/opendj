FROM java:8

MAINTAINER warren.strange@forgerock.com


WORKDIR /opt
ADD ssoadmintools.zip /tmp
RUN unzip /tmp/ssoadmintools.zip -d /opt/ssoadm && rm -fr /tmp/ssoadmintools.zip
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
WORKDIR /opt/ssoadm
#
# The OpenAM server needs to be running for ssoadm to install
# So we have to delay the setup until after the container is created.
# (At least DJ instance needs to be up  -ssoadm setup fails otherwise)
# The setup command below will *NOT* work....
#RUN /opt/ssoadm/setup --acceptLicense --path /root/openam
ADD config.sh /opt/ssoadm/config.sh
ADD ssoadm /opt/ssoadm/ssoadm

CMD ["/opt/ssoadm/config.sh"]
