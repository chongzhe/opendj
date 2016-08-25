FROM openjdk:8

MAINTAINER warren.strange@forgerock.com

WORKDIR /opt

EXPOSE 8080

ADD Dockerfile /

# download openidm nightly build and unzip
ADD openidm.zip /var/tmp/openidm.zip

RUN unzip /var/tmp/openidm.zip && \
   rm -f /var/tmp/openidm.zip  && rm -fr /opt/openidm/samples

# Uncomment to use Postgres repo
# Another (better) option is to mount a new /conf/ dir instead - to take direct control
#RUN mv /opt/openidm/conf/repo.orientdb.json  /opt/openidm/conf/repo.orientdb.json.bak
#ADD repo.jdbc.json /opt/openidm/conf/repo.jdbc.json
#ADD datasource.jdbc-default.json /opt/openidm/conf/datasource.jdbc-default.json


ADD run.sh /opt/openidm/run.sh
ADD logging.properties /opt/openidm/logging.properties

WORKDIR /opt/openidm

CMD ["/opt/openidm/run.sh"]
