FROM openjdk:8

MAINTAINER warren.strange@gmail.com

EXPOSE 8080

ADD Dockerfile /

ENV MVN_REPO=https://maven.forgerock.org/repo/repo/org/forgerock/openidm

ENV OPENIDM_VERSION=5.0.0-SNAPSHOT

# Download OpenIDM, prune the samples directory
RUN curl -s $MVN_REPO/openidm-zip/$OPENIDM_VERSION/openidm-zip-$OPENIDM_VERSION.zip \
       -o /tmp/openidm.zip \
   && unzip /tmp/openidm.zip -d /opt \
   && rm -fr /opt/openidm/samples \
   && rm /tmp/openidm.zip


ADD run.sh /opt/openidm/run.sh
ADD logging.properties /opt/openidm/logging.properties

WORKDIR /opt/openidm

ONBUILD ADD . /opt/openidm


CMD ["/opt/openidm/run.sh"]


