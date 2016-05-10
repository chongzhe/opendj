FROM tomcat:8-jre8


ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
#ENV JAVA_OPTS -Dopenig.base=/root/openig
# Default home for OpenIG config. Override this to set a different location
ENV OPENIG_BASE /root/openig
WORKDIR $CATALINA_HOME

# Let's remove some of the stuff we don't need
RUN rm -fr webapps/*

# todo:
# Fix up classpath scanning to speed up the deployment
# see http://www.gpickin.com/index.cfm/blog/how-to-get-your-tomcat-to-pounce-on-startup-not-crawl

EXPOSE 8080

ADD openig.war webapps/ROOT.war
ADD run-openig.sh /tmp/run-openig.sh

CMD ["/tmp/run-openig.sh"]
