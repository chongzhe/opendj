#
FROM tomcat:8-jre8

MAINTAINER warren.strange@forgerock.com

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME


# Note: By default tomcat does NOT listen on 8443. You must add a custom server.xml file to change this
EXPOSE 8080 8443

ENV MVN_REPO=https://maven.forgerock.org/repo/repo/org/forgerock/openam
ENV OPENAM_VERSION=14.0.0-SNAPSHOT

# Use this to download an OpenAM build from Maven
#RUN curl $MVN_REPO/openam-server/$OPENAM_VERSION/openam-server-$OPENAM_VERSION.war \
#     -o /tmp/openam.war \
# && rm -fr /usr/local/tomcat/webapps/* \
# && unzip /tmp/openam.war -d /usr/local/tomcat/webapps/openam \
# && rm /tmp/openam.war


# For testing Docker builds use local files instead - much faster
# If you want a custom openam.war you can also copy in your war file
ADD openam.war  /usr/local/tomcat/webapps/openam.war

ADD run /var/tmp/

# Generate a default keystore for SSL - only needed if you want SSL inside the cluster
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
