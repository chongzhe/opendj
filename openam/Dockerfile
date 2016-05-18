#  T
FROM tomcat:8-jre8

MAINTAINER warren.strange@gmail.com

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

EXPOSE 8080 8443

ADD openam.war  /usr/local/tomcat/webapps/openam.war

ADD run-openam.sh /tmp/run-openam.sh

# Generate a default keystore for SSL.
# You can mount your own keystore on the ssl/ directory to override this
RUN mkdir -p /usr/local/tomcat/ssl && \
   keytool -genkey -noprompt \
     -keyalg RSA \
     -alias tomcat \
     -dname "CN=forgerock.com, OU=ID, O=FORGEROCK, L=Calgary, S=AB, C=CA" \
     -keystore /usr/local/tomcat/ssl/keystore \
     -storepass password \
     -keypass password

ADD server.xml /usr/local/tomcat/conf/server.xml


CMD ["/tmp/run-openam.sh"]
