FROM tomcat:8.5

MAINTAINER warren.strange@forgerock.com

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

EXPOSE 8080 8443

ADD Dockerfile /

#ADD openam.war  /usr/local/tomcat/webapps/openam.war

ENV MVN_REPO=https://maven.forgerock.org/repo/repo/org/forgerock/openam

ENV OPENAM_VERSION=14.0.0-SNAPSHOT

ADD openam.war /usr/local/tomcat/webapps/


LABEL  io.openshift.s2i.scripts-url="image:///var/tmp/s2i/"

COPY  ["assemble", "run", "usage", "/var/tmp/s2i/"]


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



CMD ["/var/tmp/s2i/usage"]


