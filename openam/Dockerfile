#
FROM tomcat:8-jre8

MAINTAINER warren.strange@gmail.com

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

EXPOSE 8080 8443

ENV MVN_REPO=http://maven.forgerock.org/repo/repo/org/forgerock/openam
ENV OPENAM_VERSION=14.0.0-SNAPSHOT


RUN curl $MVN_REPO/openam-server/$OPENAM_VERSION/openam-server-$OPENAM_VERSION.war \
     -o /tmp/openam.war \
 && unzip /tmp/openam.war -d /usr/local/tomcat/webapps/openam \
 && curl $MVN_REPO/openam-distribution-ssoconfiguratortools/$OPENAM_VERSION/openam-distribution-ssoconfiguratortools-$OPENAM_VERSION.zip \
       -o /tmp/ssoconfig.zip \
 && rm /tmp/*zip /tmp/*war


# For testing use local files - much faster
#ADD openam.war  /usr/local/tomcat/webapps/openam.war
#ADD ssoconfigtools.zip /tmp/
#RUN unzip /tmp/ssoconfigtools -d /var/tmp/ssoconfig

ADD run /var/tmp/

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

# Custom server.xml
# Use this if OpenAM is behind SSL termination and you want port 8080 to be configured as secure
# See the server.xml file
#ADD server.xml /usr/local/tomcat/conf/server.xml



CMD ["/var/tmp/run"]
