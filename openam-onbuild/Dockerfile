FROM tomcat:8-jre8

MAINTAINER warren.strange@gmail.com

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

EXPOSE 8080 8443

ADD Dockerfile /

#ADD openam.war  /usr/local/tomcat/webapps/openam.war

ENV MVN_REPO=https://maven.forgerock.org/repo/repo/org/forgerock/openam

ENV OPENAM_VERSION=14.0.0-SNAPSHOT

RUN curl $MVN_REPO/openam-server/$OPENAM_VERSION/openam-server-$OPENAM_VERSION.war \
     -o /tmp/openam.war \
 && unzip /tmp/openam.war -d /usr/local/tomcat/webapps/openam \
 && curl $MVN_REPO/openam-distribution-ssoconfiguratortools/$OPENAM_VERSION/openam-distribution-ssoconfiguratortools-$OPENAM_VERSION.zip \
       -o /tmp/ssoconfig.zip \
 && unzip /tmp/ssoconfig.zip -d /var/tmp/ssoconfig \
 && curl $MVN_REPO/openam-distribution-ssoadmintools/$OPENAM_VERSION/openam-distribution-ssoadmintools-$OPENAM_VERSION.zip \
    -o /tmp/ssoadmin.zip \
 &&  unzip /tmp/ssoadmin.zip -d /root/admintools \
 && rm /tmp/*zip /tmp/*war

ADD ssoadm /root/admintools/
ADD config.sh /var/tmp/


ONBUILD ADD config /var/tmp/config
ONBUILD RUN /var/tmp/config.sh

# Generate a default keystore for SSL.
# You can mount your own keystore on the ssl/ directory to override this
#RUN mkdir -p /usr/local/tomcat/ssl && \
#   keytool -genkey -noprompt \
#     -keyalg RSA \
#     -alias tomcat \
#     -dname "CN=forgerock.com, OU=ID, O=FORGEROCK, L=Calgary, S=AB, C=CA" \
#     -keystore /usr/local/tomcat/ssl/keystore \
#     -storepass password \
#     -keypass password
#
#ADD server.xml /usr/local/tomcat/conf/server.



CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

