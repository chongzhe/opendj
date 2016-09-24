# Container that configures OpenAM
# Includes configurator, and will eventually contain amster
FROM openjdk:8-jre


ENV MVN_REPO=https://maven.forgerock.org/repo/repo/org/forgerock/openam
ENV OPENAM_VERSION=14.0.0-SNAPSHOT

# Use this to download from Maven
 RUN curl $MVN_REPO/openam-distribution-ssoconfiguratortools/$OPENAM_VERSION/openam-distribution-ssoconfiguratortools-$OPENAM_VERSION.zip \
       -o /tmp/ssoconfig.zip \
 && unzip /tmp/ssoconfig.zip -d /var/tmp/ssoconfig \
 && rm /tmp/ssoconfig.zip


# To build from a pre downloaded copy use this instead
# ADD ssoconfigtools.zip /var/tmp/ssoconfig.zip
# RUN  unzip ssoconfig.zip


WORKDIR /var/tmp

# Download AM configurator from maven build

COPY config.sh /var/tmp/

CMD ["/var/tmp/config.sh"]



